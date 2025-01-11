import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myapp/controller/main_menu_controller.dart';
import 'package:myapp/models/Card/card_element.dart';
import 'package:myapp/models/Card/card_level.dart';

import 'package:myapp/models/Game/vs_game.dart';
import 'package:myapp/models/User/component.dart';
import 'package:myapp/models/User/user.dart';

import 'package:myapp/utils/constants/app_constants.dart';
import 'package:myapp/views/VSGame/fight_view.dart';
import 'package:myapp/views/main_menu_view.dart';
import 'package:myapp/widgets/dialogs/turn_number.dart';
import 'package:myapp/widgets/dialogs/turn_result.dart';
import 'package:vibration/vibration.dart';

import '../models/Card/playing_card.dart';
import '../utils/permissions/permission_checker.dart';

class GameController extends GetxController with StateMixin {
  final DeviceType deviceType;
  late VSGame game;
  late String userName;
  final ElCardsUser user;
  late ElCardsOponent? oponent;

  late MobileScannerController scannerController;
  Barcode? _barcode;

  List<Device> devices = [];
  Device? connectedDevice;
  NearbyService? nearbyService;
  late StreamSubscription subscription;
  late StreamSubscription receivedDataSubscription;
  var cameraPermission = false.obs;
  var finishInit = true.obs;

  bool hasVibration = false;

  GameController({
    required this.user,
    required this.deviceType,
  });

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    debugPrint('Init GameController');
    scannerController = MobileScannerController(
      useNewCameraSelector: true,
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
    PermissionChecker.checkCamera().then((value) {
      cameraPermission.value = value;
      //update();
    });

    initNearbyService().then((_) {
      finishInit.value = true;
      if (deviceType == DeviceType.advicer) {
        game = VSGame(user);
      }
      change(null, status: RxStatus.success());
      super.onInit();
    });
  }

  @override
  void onClose() {
    if (connectedDevice != null) {
      nearbyService!.disconnectPeer(deviceID: connectedDevice!.deviceId);
    }

    nearbyService = null;
    scannerController.stop().then((_) {
      super.onClose();
    });
    user.resetCardDeck();
    user.cardSet.allCardsFromDeck();
    MainMenuController().selectedIndex.value = 1;
  }

  /*
  BARCODE
  */

  void handleBarcode(BarcodeCapture barcodes) async {
    _barcode = barcodes.barcodes.firstOrNull; //Ersten gescannten Barcode
    if (devices.isNotEmpty && _barcode != null) {
      Map<String, dynamic> data =
          json.decode(_barcode!.displayValue!); //Daten decodieren
      debugPrint('Barcode Data: $data');
      //Gegner mit übertragenen Daten anlegen
      oponent = ElCardsOponent.fromMap(
        data,
      );
      debugPrint('${oponent!.cardDeck}');
      //Device mit übertragener UserId speichern
      connectedDevice =
          devices.firstWhere((device) => device.deviceName == data['userId']);
      //Scanner Controller nach erfolgreichem Scannen schließen
      scannerController.stop();
      //Spiel erstellen
      game = VSGame.joinGame(
        user,
        oponent!,
        jsonDecode(
          data['firstTurn'],
        ),
      );
      //Wenn ein connectedes Device gefunden wurde
      if (connectedDevice != null) {
        //Nearby Connection aufbauen
        await connectToDevice(
          connectedDevice!,
        );

        //Wechsel zum Fight View
        Get.to(
          () => FightView(
            controller: this,
          ),
        );

        //Anzeige Rundenummer und wer dran ist
        Get.dialog<TurnNumberDialog>(
          barrierDismissible: false,
          TurnNumberDialog(
            round: game.turn + 1,
            ownTurn: game.ownTurn.value,
          ),
        );
      }
    }
  }

  /*
  NEARBY-Service
  */

  Future<void> initNearbyService() async {
    nearbyService = NearbyService();
    userName = FirebaseAuth.instance.currentUser!.uid;
    debugPrint('Current User: $userName');
    await nearbyService!.init(
        deviceName: userName,
        serviceType: 'mpconn',
        strategy: Strategy.P2P_POINT_TO_POINT,
        callback: (isRunning) async {
          debugPrint('Callback $isRunning');
          nearbyService!.stateChangedSubscription(callback: (deviceList) {
            debugPrint('Start StateChangeListener');
            devices.clear();
            for (Device device in deviceList) {
              devices.add(device);
              debugPrint('New Device: ${device.deviceId} ${device.deviceName}');
              update();
            }
          });
          nearbyService!.dataReceivedSubscription(
            callback: (data) {
              debugPrint('dataReceivedSubscription $data');
              handleReceivedData(data);
            },
          );
          debugPrint('Device List: $devices');
          if (deviceType == DeviceType.browser) {
            await nearbyService!.stopBrowsingForPeers();
            Future.delayed(
              const Duration(
                milliseconds: 500,
              ),
            );
            var resultBrowsing = await nearbyService!.startBrowsingForPeers();
            debugPrint('Result Browsing: $resultBrowsing');
          } else {
            await nearbyService!.startAdvertisingPeer();
            Future.delayed(
              const Duration(
                milliseconds: 500,
              ),
            );
            var resultAdvertising = await nearbyService!.startAdvertisingPeer();
            debugPrint('Result Advertising: $resultAdvertising');
          }
        });
  }

  Future<void> connectToDevice(Device device) async {
    debugPrint('connectToDevice beginning to connect');
    var result = await nearbyService!.invitePeer(
      deviceID: device.deviceId,
      deviceName: device.deviceName,
    );
    debugPrint('connectToDevice $result');
    debugPrint('connectToDevice sendData');
    await Future.delayed(const Duration(seconds: 2));
    debugPrint(
        'Send data: Connected $userName to ${connectedDevice!.deviceId}, send Cards ${user.cardDeck}');
    sendData(
      {
        'connected': userName,
        'cards': jsonEncode(user.cardDeck),
        'avatar': user.avatar,
      },
      connectedDevice!.deviceId,
    );
    debugPrint('connectToDevice Data send');
    await nearbyService!.stopAdvertisingPeer();
    debugPrint('connectToDevice stopAdvertisingPeer');
    await nearbyService!.stopBrowsingForPeers();
    debugPrint('connectToDevice stopBrowsingForPeers');
  }

  Future<void> disconnectDevice(String deviceID, {bool first = true}) async {
    if (first) {
      sendData(
        {
          'disconnected': userName,
        },
        connectedDevice!.deviceId,
      );
    }
    await resetAllData();
    await nearbyService!.disconnectPeer(deviceID: deviceID);
  }

  Future<void> resetAllData() async {
    oponent = null;
    user.resetCardDeck();
    user.cardSet.allCardsFromDeck();
    connectedDevice = null;

    try {
      await nearbyService!.stopAdvertisingPeer();
      await nearbyService!.stopBrowsingForPeers();
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar('Fehler', 'Es ist ein Fehler $e aufgetreten.');
    }
  }

  /*
  NEARY-Service Data
  */

  void sendData(Map<String, dynamic> data, String deviceID) {
    nearbyService!.sendMessage(
      deviceID,
      jsonEncode(data),
    );
  }

  Future<void> handleReceivedData(dynamic data) async {
    debugPrint('handleReceivedData data: $data');
    String stringData = data['message'] as String;
    Map<String, dynamic> receivedData = jsonDecode(stringData);
    debugPrint('Nearby Service received Data: $receivedData');
    if (receivedData.containsKey('cards')) {
      try {
        debugPrint('handleReceivedData - devices: $devices');
        connectedDevice = devices.firstWhere(
          (Device device) => device.deviceId == data['deviceId'],
        );
        List<PlayingCard?> cardDeck = [];
        for (var element in jsonDecode(receivedData['cards'])) {
          cardDeck.add(
            PlayingCard(
              CardElement.byInt(element['element']),
              CardLevel.byInt(element['level']),
              element['number'],
            ),
          );
        }
        debugPrint('Nearby Service - $cardDeck');
        oponent = ElCardsOponent(
          receivedData['connected'],
          cardDeck,
          receivedData['avatar'],
        );
        game.oponent = oponent!;
        debugPrint('handleReceivedData - create oponent $oponent');
        Get.to(() => FightView(controller: this));
        Get.dialog(
          barrierDismissible: false,
          TurnNumberDialog(
            round: game.turn + 1,
            ownTurn: game.ownTurn.value,
          ),
        );
      } catch (e) {
        Get.snackbar('Error', 'Device not found');
        await resetAllData();
        Get.offAll(() => MainMenuView());
      }
    }
    if (receivedData.containsKey('disconnected')) {
      disconnectDevice(
        connectedDevice!.deviceId,
        first: false,
      ).then((_) {
        Get.offAll(() => MainMenuView());
      });
    }
    if (receivedData.containsKey('message')) {
      Get.showSnackbar(GetSnackBar(
        message: '$data',
      ));
    }
    if (receivedData.containsKey('action')) {
      //Spieler agiert als Verteidiger
      //Gegner sendet Index der Karte und seinen gewählten ActionType
      oponent!.finishedTurn = true; //Daten vom Angreifer gehen ein
      /*Get.showSnackbar(GetSnackBar(
        message: '$data',
      ));*/
      game.setOponentCardIndex(receivedData['cardIndex']);
      game.setGameAction(receivedData['action']);
      if (user.finishTurn) {
        //Spieler hat Daten bereits abgeschickt und wartet
        Get.close(1); //"Warten auf Gegner" - Meldung ausblenden
        await calculateTurnResult();
      } else {
        //Spieler hat Daten noch nicht abgeschickt
        //TODO: Rundenergebnis nach Absenden berechnen
      }
    }
    if (receivedData.containsKey('defender')) {
      //Spieler agiert als Angreifer
      //Gegner sendet Index seiner der Karte
      oponent!.finishedTurn = true;
      //Eingegangene Gegnerdaten speichern
      game.setOponentCardIndex(receivedData['defender']);
      if (user.finishTurn) {
        //Spieler hat Daten bereits abgeschickt und wartet
        Get.close(1); //"Warten auf Gegner" - Meldung ausblenden
        await calculateTurnResult();
        //TODO: Rundenergebnis berechnen
      } else {
        //Spieler hat Daten noch nicht abgeschickt
        //TODO: Rundenergebnis nach Absenden berechnen
      }
    }
  }

  void sendDataAsAttacker(int cardIndex, ActionType action) {
    user.finishTurn = true;
    sendData(
      {
        'action': action.index,
        'cardIndex': cardIndex,
      },
      connectedDevice!.deviceId,
    );
  }

  void sendDataAsDefender(
    int cardIndex,
  ) {
    user.finishTurn = true;
    sendData(
      {
        'defender': cardIndex,
      },
      connectedDevice!.deviceId,
    );
  }

  /*
  Calculate
  Turn - Result
  */

  Future<void> calculateTurnResult() async {
    PlayingCard ownCard = game.getOwnCard()!;
    PlayingCard oponentCard = game.getOponentCard()!;
    ActionType actionType = game.getActionType()!;
    bool ownTurn = game.ownTurn.value;
    debugPrint(
      game.printCardDecks(),
    );

    //Runde berechnen und Ergebnis ausgeben
    Map turnresult = game.calculateTurn(
        game.getOwnCardIndex()!, game.getOponentCardIndex()!, actionType);

    //Dialog zum Ausgang des Zuges
    await Get.dialog(
      TurnResultDialog(
        result: turnresult['turnresult'],
        ownCard: ownCard,
        oponentCard: oponentCard,
        actionType: actionType,
        ownTurn: ownTurn,
        ownValue: turnresult['ownValue'],
        oponentValue: turnresult['oponentValue'],
      ),
    );
    if (game.active) {
      //Zurücksetzen
      oponent!.finishedTurn = false;
      user.finishTurn = false;
      //Bildschirm refreshen
      update();
      //Runde und anzeigen, wer dran ist
      Get.dialog(
        barrierDismissible: false,
        TurnNumberDialog(
          round: game.turn + 1,
          ownTurn: game.ownTurn.value,
        ),
      );
    } else {
      //Spielergebnis anzeigen
      await Get.dialog(
        showGameResult(),
      );
      //Verbindung trennen
      nearbyService!.disconnectPeer(deviceID: connectedDevice!.deviceId);
      //Alle Daten resetten
      resetAllData();
      //Zurück zur Startseite
      Get.offAll(MainMenuView());
    }
  }

  /*
  Handle Buttons
  */

  //Click Cancel Button
  void clickCancelButton() {
    user.resetCardDeck();
    user.cardSet.allCardsFromDeck();
    connectedDevice = null;
    Get.offAll(() => MainMenuView());
  }

  //If Card is clicked in the Turn
  void clickCardInTurn(int index, BuildContext context) async {
    //Wahl der Karte funktioniert nur, wenn LivePoints vorhanden sind
    if (game.ownUser.cardDeck[index]!.livePoints > 0) {
      //Wenn Karte bereits markiert ist, wird Markierung aufgehoben
      if (user.cardDeck[index]!.selectedForTurn.value == true) {
        user.cardDeck[index]!.selectedForTurn.value = false;
        return;
      }
      //Wenn eine andere Karte bereits markiert ist, werden alle Karte demarkiert
      if (user.cardDeck
          .any((element) => element!.selectedForTurn.value == true)) {
        user.deselectAllCardsForTurn(); //alle Karten demarkieren
      }
      user.cardDeck[index]!.selectedForTurn.value =
          true; //Gewählte Karte markieren
      //Wenn Spieler angreift
      if (game.ownTurn.value) {
        var result = await Get.dialog(
          showGameActionDialog(index), //Auswahl der drei GameActions zeigen
        );

        if (result == null) {
          user.deselectAllCardsForTurn(); //Wenn Spieler keine GameAction wählt werden Karten demarkiert
        }
      } else {
        //Wenn Gegner GameActions wählt
        var result = await Get.dialog(
          showDefenderDialog(
              index), //Bestätigung, dass Karte gewählt werden soll
        );
        if (result == null) {
          user.deselectAllCardsForTurn(); //Wenn Spieler keine Dialog schließt ohne Auswahl werden Karten demarkiert
        }
      }
    } else {
      await Vibration.vibrate(duration: 500);
    }

    debugPrint(
        'GameController - Click Card with Index $index is selected in turn: ${user.cardDeck[index]!.selectedForTurn}');
  }

  //Dialog after choose a Card as Defender
  Widget showDefenderDialog(int cardIndex) {
    return AlertDialog(
      title: const Text("Confirm Card-Selection"),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      actionsOverflowButtonSpacing: 20,
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.close(1);
            },
            child: const Text("No")),
        ElevatedButton(
            onPressed: () async {
              sendDataAsDefender(cardIndex);
              game.setOwnCardIndex(cardIndex);
              Get.close(1);
              if (oponent!.finishedTurn == false) {
                //Gegner hat noch keine Daten gesendet
                //Berechnung Rundenergebnis erst bei Eingang der Daten
                Get.dialog(showWaitingOfOponentDialog());
              } else {
                //Gegnerdaten liegen bereits vor
                //Rundenergebnis kann berechnet werden
                await calculateTurnResult();
              }
            },
            child: const Text("Yes")),
      ],
      content: const Text("Do you want to use the card against your opponent?"),
    );
  }

  Future<void> clickGameActionButton(
      int cardIndex, ActionType actionType) async {
    sendDataAsAttacker(cardIndex, actionType);
    game.setOwnCardIndex(cardIndex);
    game.setGameAction(actionType.index);
    Get.close(1);
    if (oponent!.finishedTurn == false) {
      //Gegner hat noch keine Daten gesendet
      //Berechnung Rundenergebnis erst bei Eingang der Daten
      Get.dialog(
        showWaitingOfOponentDialog(),
      );
    } else {
      //Gegnerdaten liegen bereits vor
      //Rundenergebnis kann berechnet werden
      await calculateTurnResult();
    }
  }

  //Dialog after choose a Card as Attacker
  Widget showGameActionDialog(int cardIndex) {
    return AlertDialog(
      title: const Text("Please select"),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      actionsOverflowButtonSpacing: 10,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actions: [
        TextButton.icon(
          onPressed: () async {
            clickGameActionButton(cardIndex, ActionType.attack);
          },
          label: Text('Attack (${user.cardDeck[cardIndex]!.attack})'),
          icon: const Icon(Icons.arrow_forward),
        ),
        TextButton.icon(
          onPressed: () {
            clickGameActionButton(cardIndex, ActionType.defend);
          },
          label: Text('Defend (${user.cardDeck[cardIndex]!.defense})'),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        TextButton.icon(
          onPressed: () {
            clickGameActionButton(cardIndex, ActionType.escape);
          },
          label: Text('Escape (${user.cardDeck[cardIndex]!.speed})'),
          icon: const Icon(Icons.speed),
        ),
      ],
      content: const Text("Which move do you want to use?"),
    );
  }

  Widget showWaitingOfOponentDialog() {
    return const AlertDialog(
      title: Text("Waiting..."),
      content: Text("...for oponents move."),
    );
  }

  Widget showGameResult() {
    switch (game.wonGame) {
      //Unentschieden
      case null:
        return AlertDialog(
          title: const Text('It\'s a draw,'),
          content: Text('You two have achieved ${game.ownPoints} points.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.close(1);
              },
              child: const Text(
                'OK',
              ),
            )
          ],
        );

      //Spieler gewinnt
      case true:
        return AlertDialog(
          title: const Text('You won'),
          content: Column(
            children: [
              Text(
                'Your Points: ${game.ownPoints}',
              ),
              Text(
                'Oponent Points: ${game.oponentPoints}',
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.close(1);
              },
              child: const Text(
                'OK',
              ),
            )
          ],
        );

      //Gegner gewinnt
      case false:
        return AlertDialog(
          title: const Text('You lost'),
          content: Column(
            children: [
              Text(
                'Your Points: ${game.ownPoints}',
              ),
              Text(
                'Oponent Points: ${game.oponentPoints}',
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.close(1);
              },
              child: const Text(
                'OK',
              ),
            )
          ],
        );
    }
  }
}
