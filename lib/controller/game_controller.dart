import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myapp/models/Card/playing_card.dart';

import 'package:myapp/models/Game/vs_game.dart';
import 'package:myapp/models/User/component.dart';
import 'package:myapp/models/User/user.dart';

import 'package:myapp/utils/constants/app_constants.dart';
import 'package:myapp/views/Game/fight_view.dart';
import 'package:myapp/views/main_menu_view.dart';

import '../utils/permissions/permission_checker.dart';

class GameController extends GetxController {
  final DeviceType deviceType;
  late VSGame game;
  late String userName;
  final ElCardsUser user;
  late ElCardsComponent component;

  late MobileScannerController scannerController;
  Barcode? _barcode;

  List<Device> devices = [];
  Device? connectedDevice;
  NearbyService? nearbyService;
  late StreamSubscription subscription;
  late StreamSubscription receivedDataSubscription;
  var cameraPermission = false.obs;
  var finishInit = true.obs;

  GameController({
    required this.user,
    required this.deviceType,
  });

  @override
  void onInit() {
    debugPrint('Init GameController');
    scannerController = MobileScannerController(
      useNewCameraSelector: true,
    );

    PermissionChecker.checkCamera().then((value) {
      cameraPermission.value = value;
    });

    initNearbyService().then((_) {
      finishInit.value = true;
      super.onInit();
    });
  }

  void handleBarcode(BarcodeCapture barcodes) {
    _barcode = barcodes.barcodes.firstOrNull; //Ersten gescannten Barcode
    if (devices.isNotEmpty && _barcode != null) {
      Map<String, dynamic> data =
          json.decode(_barcode!.displayValue!); //Daten decodieren
      debugPrint('Barcode Data: $data');
      //Gegner mit übertragenen Daten anlegen
      component = ElCardsComponent.fromMap(
        data,
      );
      debugPrint('${component.cardDeck}');
      //Device mit übertragener UserId speichern
      connectedDevice =
          devices.firstWhere((device) => device.deviceName == data['userId']);
      //Scanner Controller nach erfolgreichem Scannen schließen
      scannerController.stop();
      //Wenn ein connectedes Device gefunden wurde
      if (connectedDevice != null) {
        //Nearby Connection aufbauen
        connectToDevice(connectedDevice!).then((value) {
          debugPrint('Nearby Service: ${connectedDevice!.deviceId} connected');
          //Wechsel zum Fight View
          Get.to(
            () => FightView(
              controller: this,
            ),
          );
        });
      }
    }
  }

  @override
  void dispose() {
    nearbyService = null;
    scannerController.stop().then((_) {
      super.dispose();
    });
  }

  Future<void> initNearbyService() async {
    nearbyService = NearbyService();
    userName = FirebaseAuth.instance.currentUser!.uid;
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
              debugPrint('New Device: ${device.deviceId}');
              update();
            }
          });
          nearbyService!.dataReceivedSubscription(
            callback: (data) {
              debugPrint('$data');
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

  void handleReceivedData(dynamic data) {
    String stringData = data['message'] as String;
    Map<String, dynamic> receivedData = jsonDecode(stringData);
    debugPrint('Nearby Service received Data: $receivedData');
    if (receivedData.containsKey('connected')) {
      debugPrint('Nearby Service received Data contains connected');
      String deviceName = receivedData['connected'];
      connectedDevice =
          devices.firstWhere((device) => device.deviceName == deviceName);
      Get.to(() => FightView(controller: this));
    }
    if (receivedData.containsKey('disconnected')) {
      disconnectDevice(connectedDevice!.deviceId).then((_) {
        Get.offAll(() => MainMenuView());
      });
    }
  }

  Future<void> connectToDevice(Device device) async {
    var result = await nearbyService!.invitePeer(
      deviceID: device.deviceId,
      deviceName: device.deviceName,
    );
  }

  void sendData(Map<String, dynamic> data, String deviceID) {
    nearbyService!.sendMessage(
      deviceID,
      jsonEncode(data),
    );
  }

  Future<void> disconnectDevice(String deviceID) async {
    sendData({
      'disconnected': userName,
    }, connectedDevice!.deviceId);
    await nearbyService!.disconnectPeer(deviceID: deviceID);
    await nearbyService!.stopAdvertisingPeer();
    await nearbyService!.stopBrowsingForPeers();
  }

  int setBeginner() {
    return Random().nextInt(2);
  }

  Future<String?> createGame() async {
    DateTime now = DateTime.now();
    int pin = Random().nextInt(9999);
    List<String> players = [FirebaseAuth.instance.currentUser!.uid];
    game = VSGame('1', players, setBeginner(), now, pin, isHost: true);
    return null;
  }
}
