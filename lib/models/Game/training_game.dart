import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/models/User/trainer_model.dart';
import 'package:myapp/models/User/user.dart';

import '../../utils/constants/app_constants.dart';
import '../Card/card_element.dart';
import '../Card/playing_card.dart';

class TrainingGame {
  final ElCardsUser ownUser;
  final TrainerModel trainer = TrainerModel();
  var active = true.obs;
  var wonGame = false.obs;
  GameResult? gameResult;
  var turn = 0.obs;
  final RxBool ownTurn;
  var ownPoints = 0.obs;
  var trainerPoints = 0.obs;
  Map<String, dynamic> turnData = {
    'ownCardIndex': null,
    'oponentCardIndex': null,
    'actionType': null
  };

  TrainingGame({
    required this.ownUser,
    required this.ownTurn,
  });

  void setOwnCardIndex(int index) {
    turnData['ownCardIndex'] = index;
  }

  void setOponentCardIndex(int index) {
    turnData['oponentCardIndex'] = index;
  }

  void setActionType(ActionType actionType) {
    turnData['actionType'] = actionType;
  }

  int? getOwnCardIndex() {
    return turnData['ownCardIndex'];
  }

  int? getOponentCardIndex() {
    return turnData['oponentCardIndex'];
  }

  ActionType? getActionType() {
    return turnData['actionType'];
  }

  PlayingCard? getOwnCard() {
    return ownUser.cardDeck[getOwnCardIndex()!];
  }

  PlayingCard? getOponentCard() {
    return trainer.cardDeck[getOponentCardIndex()!];
  }

  Map calculateTurn(
      int ownCardIndex, int oponentCardIndex, ActionType actionType) {
    int ownValue;
    int oponentValue;

    PlayingCard ownCard = ownUser.cardDeck[ownCardIndex]!;
    PlayingCard oponentCard = trainer.cardDeck[oponentCardIndex];

    CardElement ownElement = ownCard.cardElement;
    CardElement oponentElement = oponentCard.cardElement;

    debugPrint(
        'TrainingGame - Eigenes Element: $ownElement Level:${ownUser.cardDeck[ownCardIndex]!.cardLevel}');
    debugPrint(
        'TrainingGame - Gegner Element: $oponentElement Level: ${trainer.cardDeck[oponentCardIndex].cardLevel}');
    //Spieler wählt ActionType
    if (ownTurn.value) {
      debugPrint('TrainingGame --> Spieler wählt ActionType $actionType');
      switch (actionType) {
        case ActionType.attack:
          //Spielers Attack-Wert gegen Gegners Defense-Wert
          if (ownElement.beats(oponentElement)) {
            //Wenn eigenes Element Gegner-Element schlägt, Gegner ein Level niedriger
            ownValue = ownCard.attack;
            oponentValue = oponentCard.lowerDefense();
            debugPrint(
                'TrainingGame - Dein $ownElement schlägt $oponentElement');
          } else if (ownElement.isBeatenBy(oponentElement)) {
            //Wenn eigenes Element von Gegner-Element geschlagen wird, Spieler ein Level niedriger
            ownValue = ownCard.lowerAttack();
            oponentValue = oponentCard.defense;
            debugPrint(
                'TrainingGame - Dein $ownElement wird von $oponentElement geschlagen');
          } else {
            //Kein Element schlägt das andere
            ownValue = ownCard.attack;
            oponentValue = oponentCard.defense;
            debugPrint('TrainingGame - Kein Vorteil für beide');
          }
        case ActionType.defend:
          //Spielers Defense-Wert gegen Gegners Attack-Wert
          if (ownElement.beats(oponentElement)) {
            //Wenn eigenes Element Gegner-Element schlägt, Gegner ein Level niedriger
            ownValue = ownCard.defense;
            oponentValue = oponentCard.lowerAttack();
            debugPrint(
                'TrainingGame - Dein $ownElement schlägt $oponentElement');
          } else if (ownElement.isBeatenBy(oponentElement)) {
            //Wenn eigenes Element von Gegner-Element geschlagen wird, Spieler ein Level niedriger
            ownValue = ownCard.lowerDefense();
            oponentValue = oponentCard.attack;
            debugPrint(
                'TrainingGame - Dein $ownElement wird von $oponentElement geschlagen');
          } else {
            //Kein Element schlägt das andere
            ownValue = ownCard.defense;
            oponentValue = oponentCard.attack;
            debugPrint('TrainingGame - Kein Vorteil für beide');
          }
        case ActionType.escape:
          //Beide Speed Werte
          if (ownElement.beats(oponentElement)) {
            //Wenn eigenes Element Gegner-Element schlägt, Gegner ein Level niedriger
            ownValue = ownCard.speed;
            oponentValue = oponentCard.lowerSpeed();
            debugPrint(
                'TrainingGame - Dein $ownElement schlägt $oponentElement');
          } else if (ownElement.isBeatenBy(oponentElement)) {
            //Wenn eigenes Element von Gegner-Element geschlagen wird, Spieler ein Level niedriger
            ownValue = ownCard.lowerSpeed();
            oponentValue = oponentCard.speed;
            debugPrint(
                'TrainingGame - Dein $ownElement wird von $oponentElement geschlagen');
          } else {
            //Kein Element schlägt das andere
            ownValue = ownCard.speed;
            oponentValue = oponentCard.speed;
            debugPrint('TrainingGame - Kein Vorteil für beide');
          }
      }
      //Gegner wähl ActionType
    } else {
      debugPrint('TrainingGame --> Gegner wählt ActionType $actionType');
      switch (actionType) {
        case ActionType.attack:
          //Spielers Defense-Wert gegen Gegners Attack-Wert
          if (ownElement.beats(oponentElement)) {
            //Wenn eigenes Element Gegner-Element schlägt, Gegner ein Level niedriger
            ownValue = ownCard.defense;
            oponentValue = oponentCard.lowerAttack();
            debugPrint(
                'TrainingGame - Dein $ownElement schlägt $oponentElement');
          } else if (ownElement.isBeatenBy(oponentElement)) {
            //Wenn eigenes Element von Gegner-Element geschlagen wird, Spieler ein Level niedriger
            ownValue = ownCard.lowerDefense();
            oponentValue = oponentCard.attack;
            debugPrint(
                'TrainingGame - Dein $ownElement wird von $oponentElement geschlagen');
          } else {
            //Kein Element schlägt das andere
            ownValue = ownCard.defense;
            oponentValue = oponentCard.attack;
            debugPrint('TrainingGame - Kein Vorteil für beide');
          }
        case ActionType.defend:
          //Spielers Attack-Wert gegen Gegners Defense-Wert
          if (ownElement.beats(oponentElement)) {
            //Wenn eigenes Element Gegner-Element schlägt, Gegner ein Level niedriger
            ownValue = ownCard.attack;
            oponentValue = oponentCard.lowerDefense();
            debugPrint(
                'TrainingGame - Dein $ownElement schlägt $oponentElement');
          } else if (ownElement.isBeatenBy(oponentElement)) {
            //Wenn eigenes Element von Gegner-Element geschlagen wird, Spieler ein Level niedriger
            ownValue = ownCard.lowerAttack();
            oponentValue = oponentCard.defense;
            debugPrint(
                'TrainingGame - Dein $ownElement wird von $oponentElement geschlagen');
          } else {
            //Kein Element schlägt das andere
            ownValue = ownCard.attack;
            oponentValue = oponentCard.defense;
            debugPrint('TrainingGame - Kein Vorteil für beide');
          }
        case ActionType.escape:
          //Beide Speed Werte
          if (ownElement.beats(oponentElement)) {
            //Wenn eigenes Element Gegner-Element schlägt, Gegner ein Level niedriger
            ownValue = ownCard.speed;
            oponentValue = oponentCard.lowerSpeed();
            debugPrint(
                'TrainingGame - Dein $ownElement schlägt $oponentElement');
          } else if (ownElement.isBeatenBy(oponentElement)) {
            //Wenn eigenes Element von Gegner-Element geschlagen wird, Spieler ein Level niedriger
            ownValue = ownCard.lowerSpeed();
            oponentValue = oponentCard.speed;
            debugPrint(
                'TrainingGame - Dein $ownElement wird von $oponentElement geschlagen');
          } else {
            //Kein Element schlägt das andere
            ownValue = ownCard.speed;
            oponentValue = oponentCard.speed;
            debugPrint('TrainingGame - Kein Vorteil für beide');
          }
      }
    }
    debugPrint(
        'TrainingGame - OwnValue: $ownValue OponentValue: $oponentValue');
    if (ownValue > oponentValue) {
      ownPoints.value++;
      oponentCard.reduceLivePoints();
      debugPrint(
          'TrainingGame - Spieler gewinnt Runde - Punkte Spieler: ${ownPoints.value}, Punkte Gegner ${trainerPoints.value}');
      nextTurn();

      return {
        'turnresult': TurnResult.beats,
        'ownValue': ownValue,
        'oponentValue': oponentValue
      };
    } else if (ownValue < oponentValue) {
      trainerPoints.value++;
      ownCard.reduceLivePoints();
      debugPrint(
          'TrainingGame - Gegner gewinnt Runde - Punkte Spieler: ${ownPoints.value}, Punkte Gegner ${trainerPoints.value}');
      nextTurn();
      return {
        'turnresult': TurnResult.beaten,
        'ownValue': ownValue,
        'oponentValue': oponentValue
      };
    } else {
      debugPrint(
          'TrainingGame - Keiner gewinnt Runde - Punkte Spieler: ${ownPoints.value}, Punkte Gegner ${trainerPoints.value}');
      nextTurn();
      return {
        'turnresult': TurnResult.draw,
        'ownValue': ownValue,
        'oponentValue': oponentValue
      };
    }
  }

  void nextTurn() {
    //Wenn ein Spieler 3 Punkte erreicht, ist das Spiel beendet
    if (ownPoints.value >= 3) {
      active.value = false;
      wonGame.value = true;
      gameResult = GameResult.won;
      debugPrint('TrainingGame - Spieler hat gewonnen, Spiel beendet');
      return;
    }
    if (trainerPoints.value >= 3) {
      active.value = false;
      wonGame.value = false;
      gameResult = GameResult.lost;
      debugPrint('TrainingGame - Gegner hat gewonnen, Spiel beendet');
      return;
    }
    //Wenn 5 Runden gespielt, dann ist Spiel beendet
    if (turn >= 4) {
      active.value = false;
      debugPrint('TrainingGame - 5 Runden gespielt, Spiel beendet');
      if (ownPoints.value > trainerPoints.value) {
        wonGame.value = true;
        gameResult = GameResult.won;
        debugPrint(
            'Spieler gewinnt mit ${ownPoints.value} zu ${trainerPoints.value}');
      } else if (ownPoints.value < trainerPoints.value) {
        wonGame.value = false;
        gameResult = GameResult.lost;
        debugPrint(
            'Gegner gewinnt mit ${trainerPoints.value} zu ${ownPoints.value}');
      }
    }

    //Eine Runde weiter
    turn++;
    ownTurn.value = !ownTurn.value;
    debugPrint('TrainingGame - Neue Runde ($turn)');
  }
}
