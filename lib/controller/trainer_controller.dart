import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/main_menu_controller.dart';
import 'package:myapp/models/Card/card_attributes.dart';
import 'package:myapp/models/Game/training_game.dart';
import 'package:myapp/views/main_menu_view.dart';
import 'package:myapp/widgets/dialogs/new_turn_result.dart';
import 'package:vibration/vibration.dart';

import '../models/Card/playing_card.dart';
import '../utils/constants/app_constants.dart';
import '../widgets/dialogs/turn_number.dart';

class TrainerController extends GetxController with StateMixin {
  MainMenuController mainMenuController = Get.find();

  late TrainingGame game;

  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    game = TrainingGame(
      ownTurn: randomTurn().obs,
      ownUser: mainMenuController.user!,
    );
    debugPrint('TrainerCardDeck: ${game.trainer.cardDeck}');
    change(null, status: RxStatus.success());
    super.onInit();
  }

  @override
  void onReady() {
    Get.dialog(
      barrierDismissible: false,
      TurnNumberDialog(
        round: game.turn.value + 1,
        ownTurn: game.ownTurn.value,
      ),
    );
    super.onReady();
  }

  @override
  void onClose() {
    game.ownUser.resetCardDeck();
    game.ownUser.cardSet.allCardsFromDeck();
    MainMenuController().selectedIndex.value = 1;
    super.onClose();
  }

  bool randomTurn() {
    Random random = Random();
    return random.nextBool();
  }

  void testFunction() {
    debugPrint('TestFunction');
    for (int i = 0; i < 30; i++) {
      int randomIndex = CardAttribute.getRandomIndex();
      debugPrint(
        randomIndex < 27 ? 'under 27' : 'over 27',
      );
    }
  }

  //If Card is clicked in the Turn
  void clickCardInTurn(int index, BuildContext context) async {
    //Wahl der Karte funktioniert nur, wenn LivePoints vorhanden sind
    if (game.ownUser.cardDeck[index]!.livePoints > 0) {
      //Wenn Karte bereits markiert ist, wird Markierung aufgehoben
      if (game.ownUser.cardDeck[index]!.selectedForTurn.value == true) {
        game.ownUser.cardDeck[index]!.selectedForTurn.value = false;
        return;
      }
      //Wenn eine andere Karte bereits markiert ist, werden alle Karte demarkiert
      if (game.ownUser.cardDeck
          .any((element) => element!.selectedForTurn.value == true)) {
        game.ownUser.deselectAllCardsForTurn(); //alle Karten demarkieren
      }
      game.ownUser.cardDeck[index]!.selectedForTurn.value =
          true; //Gewählte Karte markieren
      //Wenn Spieler angreift
      if (game.ownTurn.value) {
        var result = await Get.dialog(
          showGameActionDialog(index), //Auswahl der drei GameActions zeigen
        );

        if (result == null) {
          game.ownUser
              .deselectAllCardsForTurn(); //Wenn Spieler keine GameAction wählt werden Karten demarkiert
        }
      } else {
        //Wenn Gegner GameActions wählt
        var result = await Get.dialog(
          showDefenderDialog(
              index), //Bestätigung, dass Karte gewählt werden soll
        );
        if (result == null) {
          game.ownUser
              .deselectAllCardsForTurn(); //Wenn Spieler keine Dialog schließt ohne Auswahl werden Karten demarkiert
        }
      }
    } else {
      await Vibration.vibrate(duration: 500);
    }

    debugPrint(
        'GameController - Click Card with Index $index is selected in turn: ${game.ownUser.cardDeck[index]!.selectedForTurn}');
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
              game.setOwnCardIndex(cardIndex);
              game.setOponentCardIndex(game.trainer.getRandomCardIndex());
              game.setActionType(game.trainer.getRandomActionType());
              Get.close(1);
              Get.dialog(
                barrierDismissible: false,
                showWaitingOfOponentDialog(),
              );

              await Future.delayed(
                const Duration(
                  seconds: 2,
                ),
              );
              Get.close(1);
              await calculateTurnResult();
            },
            child: const Text("Yes")),
      ],
      content: const Text("Do you want to use the card against your opponent?"),
    );
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
          label: Text('Attack (${game.ownUser.cardDeck[cardIndex]!.attack})'),
          icon: const Icon(Icons.arrow_forward),
        ),
        TextButton.icon(
          onPressed: () {
            clickGameActionButton(cardIndex, ActionType.defend);
          },
          label: Text('Defend (${game.ownUser.cardDeck[cardIndex]!.defense})'),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        TextButton.icon(
          onPressed: () {
            clickGameActionButton(cardIndex, ActionType.escape);
          },
          label: Text('Escape (${game.ownUser.cardDeck[cardIndex]!.speed})'),
          icon: const Icon(Icons.speed),
        ),
      ],
      content: const Text("Which move do you want to use?"),
    );
  }

  Future<void> clickGameActionButton(
      int cardIndex, ActionType actionType) async {
    game.setOwnCardIndex(cardIndex);
    game.setActionType(actionType);
    game.setOponentCardIndex(game.trainer.getRandomCardIndex());
    Get.close(1);
    Get.dialog(
      barrierDismissible: false,
      showWaitingOfOponentDialog(),
    );

    await Future.delayed(const Duration(seconds: 2));
    Get.close(1);
    await calculateTurnResult();
  }

  Widget showWaitingOfOponentDialog() {
    return const AlertDialog(
      title: Text("Waiting..."),
      content: Text("...for oponents move."),
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

    //Runde berechnen und Ergebnis ausgeben
    Map turnresult = game.calculateTurn(
      game.getOwnCardIndex()!,
      game.getOponentCardIndex()!,
      actionType,
    );

    //Dialog zum Ausgang des Zuges
    await Get.dialog(
      NewTurnResult(
        result: turnresult['turnresult'],
        ownCard: ownCard,
        oponentCard: oponentCard,
        actionType: actionType,
        ownTurn: ownTurn,
        ownValue: turnresult['ownValue'],
        oponentValue: turnresult['oponentValue'],
      ),
    );
    if (game.active.value) {
      //Runde und anzeigen, wer dran ist
      await Get.dialog(
        barrierDismissible: false,
        TurnNumberDialog(
          round: game.turn.value + 1,
          ownTurn: game.ownTurn.value,
        ),
      );

      //Bildschirm refreshen
      update();
    } else {
      //Spielergebnis anzeigen
      await Get.dialog(
        showGameResult(),
      );
    }
  }

  void cancelTraining() {
    Get.offAll(
      () => MainMenuView(),
    );
  }

  Widget showGameResult() {
    switch (game.gameResult!) {
      //Spieler gewinnt
      case GameResult.won:
        return AlertDialog(
          title: const Text('You won'),
          content: Column(
            children: [
              Text(
                'Your Points: ${game.ownPoints}',
              ),
              Text(
                'Oponent Points: ${game.trainerPoints}',
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
      case GameResult.lost:
        return AlertDialog(
          title: const Text('You lost'),
          content: Column(
            children: [
              Text(
                'Your Points: ${game.ownPoints}',
              ),
              Text(
                'Oponent Points: ${game.trainerPoints}',
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
