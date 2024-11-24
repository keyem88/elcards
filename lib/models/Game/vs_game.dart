import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/models/Card/card_element.dart';
import 'package:myapp/models/Card/playing_card.dart';
import 'package:myapp/models/User/component.dart';
import 'package:myapp/models/User/user.dart';
import 'package:myapp/utils/constants/app_constants.dart';

class VSGame {
  late String id;
  final ElCardsUser ownUser;
  late ElCardsOponent oponent;
  var ownTurn = false.obs;
  bool active = true;
  int turn = 0;
  var ownPoints = 0.obs;
  var oponentPoints = 0.obs;
  int _lastCardIndex = -1;
  bool? wonGame;
  Map<String, dynamic> turnData = {
    'ownCardIndex': null,
    'oponentCardIndex': null,
    'gameAction': null
  };

  VSGame(
    this.ownUser,
  ) {
    ownTurn.value = firstTurn();
    debugPrint('VSGame - created');
    debugPrint(
        ownTurn.value ? 'VSGame - Spieler beginnt' : 'VSGame - Gegner beginnt');
  }

  factory VSGame.joinGame(
      ElCardsUser ownUser, ElCardsOponent oponent, bool ownTurn) {
    VSGame game = VSGame(ownUser);
    game.oponent = oponent;
    game.ownTurn.value = ownTurn;
    debugPrint('VSGame - Spiel beigetreten');
    return game;
  }

  void setOwnCardIndex(int index) {
    turnData['ownCardIndexIndex'] = index;
  }

  void setOponentCardIndex(int index) {
    turnData['oponentCardIndexIndex'] = index;
  }

  void setGameAction(int index) {
    turnData['gameAction'] = ActionType.values[index];
  }

  int? getOwnCardIndex() {
    return turnData['ownCardIndexIndex'];
  }

  int? getOponentCardIndex() {
    return turnData['oponentCardIndexIndex'];
  }

  ActionType? getActionType() {
    return turnData['gameAction'];
  }

  PlayingCard? getOwnCard() {
    return ownUser.cardDeck[getOwnCardIndex()!];
  }

  PlayingCard? getOponentCard() {
    return oponent.cardDeck[getOponentCardIndex()!];
  }

  int getLastCardIndex() {
    return _lastCardIndex;
  }

  void setLastCardIndex(int index) {
    _lastCardIndex = index;
  }

  void nextTurn() {
    //Wenn ein Spieler 3 Punkte erreicht, ist das Spiel beendet
    if (ownPoints.value >= 3) {
      active = false;
      wonGame = true;
      debugPrint('VSGame - Spieler hat gewonnen, Spiel beendet');
      return;
    }
    if (oponentPoints.value >= 3) {
      active = false;
      wonGame = false;
      debugPrint('VSGame - Gegner hat gewonnen, Spiel beendet');
      return;
    }
    //Eine Runde weiter
    turn++;
    ownTurn.value = !ownTurn.value;
    debugPrint('VSGame - Neue Runde ($turn)');
    //Wenn 5 Runden gespielt, dann ist Spiel beendet
    if (turn > 5) {
      active = false;
      debugPrint('VSGame - 5 Runden gespielt, Spiel beendet');
      if (ownPoints.value > oponentPoints.value) {
        wonGame = true;
        debugPrint(
            'Spieler gewinnt mit ${ownPoints.value} zu ${oponentPoints.value}');
      } else if (ownPoints.value < oponentPoints.value) {
        wonGame = false;
        debugPrint(
            'Gegner gewinnt mit ${oponentPoints.value} zu ${ownPoints.value}');
      }
    }
  }

  Map calculateTurn(
      int ownCardIndex, int oponentCardIndex, ActionType actionType) {
    int ownValue;
    int oponentValue;

    PlayingCard ownCard = ownUser.cardDeck[ownCardIndex]!;
    PlayingCard oponentCard = oponent.cardDeck[oponentCardIndex]!;

    CardElement ownElement = ownCard.cardElement;
    CardElement oponentElement = oponentCard.cardElement;

    debugPrint(
        'VSGame - Eigenes Element: $ownElement Level:${ownUser.cardDeck[ownCardIndex]!.cardLevel}');
    debugPrint(
        'VSGame - Gegner Element: $oponentElement Level: ${oponent.cardDeck[oponentCardIndex]!.cardLevel}');
    //Spieler wählt ActionType
    if (ownTurn.value) {
      debugPrint('VSGame --> Spieler wählt ActionType $actionType');
      switch (actionType) {
        case ActionType.attack:
          //Spielers Attack-Wert gegen Gegners Defense-Wert
          if (ownElement.beats(oponentElement)) {
            //Wenn eigenes Element Gegner-Element schlägt, Gegner ein Level niedriger
            ownValue = ownCard.attack;
            oponentValue = oponentCard.lowerDefense();
            debugPrint('VSGame - Dein $ownElement schlägt $oponentElement');
          } else if (ownElement.isBeatenBy(oponentElement)) {
            //Wenn eigenes Element von Gegner-Element geschlagen wird, Spieler ein Level niedriger
            ownValue = ownCard.lowerAttack();
            oponentValue = oponentCard.defense;
            debugPrint(
                'VSGame - Dein $ownElement wird von $oponentElement geschlagen');
          } else {
            //Kein Element schlägt das andere
            ownValue = ownCard.attack;
            oponentValue = oponentCard.defense;
            debugPrint('VSGame - Kein Vorteil für beide');
          }
        case ActionType.defend:
          //Spielers Defense-Wert gegen Gegners Attack-Wert
          if (ownElement.beats(oponentElement)) {
            //Wenn eigenes Element Gegner-Element schlägt, Gegner ein Level niedriger
            ownValue = ownCard.defense;
            oponentValue = oponentCard.lowerAttack();
            debugPrint('VSGame - Dein $ownElement schlägt $oponentElement');
          } else if (ownElement.isBeatenBy(oponentElement)) {
            //Wenn eigenes Element von Gegner-Element geschlagen wird, Spieler ein Level niedriger
            ownValue = ownCard.lowerDefense();
            oponentValue = oponentCard.attack;
            debugPrint(
                'VSGame - Dein $ownElement wird von $oponentElement geschlagen');
          } else {
            //Kein Element schlägt das andere
            ownValue = ownCard.defense;
            oponentValue = oponentCard.attack;
            debugPrint('VSGame - Kein Vorteil für beide');
          }
        case ActionType.escape:
          //Beide Speed Werte
          if (ownElement.beats(oponentElement)) {
            //Wenn eigenes Element Gegner-Element schlägt, Gegner ein Level niedriger
            ownValue = ownCard.speed;
            oponentValue = oponentCard.lowerSpeed();
            debugPrint('VSGame - Dein $ownElement schlägt $oponentElement');
          } else if (ownElement.isBeatenBy(oponentElement)) {
            //Wenn eigenes Element von Gegner-Element geschlagen wird, Spieler ein Level niedriger
            ownValue = ownCard.lowerSpeed();
            oponentValue = oponentCard.speed;
            debugPrint(
                'VSGame - Dein $ownElement wird von $oponentElement geschlagen');
          } else {
            //Kein Element schlägt das andere
            ownValue = ownCard.speed;
            oponentValue = oponentCard.speed;
            debugPrint('VSGame - Kein Vorteil für beide');
          }
      }
      //Gegner wähl ActionType
    } else {
      debugPrint('VSGame --> Gegner wählt ActionType $actionType');
      switch (actionType) {
        case ActionType.attack:
          //Spielers Defense-Wert gegen Gegners Attack-Wert
          if (ownElement.beats(oponentElement)) {
            //Wenn eigenes Element Gegner-Element schlägt, Gegner ein Level niedriger
            ownValue = ownCard.defense;
            oponentValue = oponentCard.lowerAttack();
            debugPrint('VSGame - Dein $ownElement schlägt $oponentElement');
          } else if (ownElement.isBeatenBy(oponentElement)) {
            //Wenn eigenes Element von Gegner-Element geschlagen wird, Spieler ein Level niedriger
            ownValue = ownCard.lowerDefense();
            oponentValue = oponentCard.attack;
            debugPrint(
                'VSGame - Dein $ownElement wird von $oponentElement geschlagen');
          } else {
            //Kein Element schlägt das andere
            ownValue = ownCard.defense;
            oponentValue = oponentCard.attack;
            debugPrint('VSGame - Kein Vorteil für beide');
          }
        case ActionType.defend:
          //Spielers Attack-Wert gegen Gegners Defense-Wert
          if (ownElement.beats(oponentElement)) {
            //Wenn eigenes Element Gegner-Element schlägt, Gegner ein Level niedriger
            ownValue = ownCard.attack;
            oponentValue = oponentCard.lowerDefense();
            debugPrint('VSGame - Dein $ownElement schlägt $oponentElement');
          } else if (ownElement.isBeatenBy(oponentElement)) {
            //Wenn eigenes Element von Gegner-Element geschlagen wird, Spieler ein Level niedriger
            ownValue = ownCard.lowerAttack();
            oponentValue = oponentCard.defense;
            debugPrint(
                'VSGame - Dein $ownElement wird von $oponentElement geschlagen');
          } else {
            //Kein Element schlägt das andere
            ownValue = ownCard.attack;
            oponentValue = oponentCard.defense;
            debugPrint('VSGame - Kein Vorteil für beide');
          }
        case ActionType.escape:
          //Beide Speed Werte
          if (ownElement.beats(oponentElement)) {
            //Wenn eigenes Element Gegner-Element schlägt, Gegner ein Level niedriger
            ownValue = ownCard.speed;
            oponentValue = oponentCard.lowerSpeed();
            debugPrint('VSGame - Dein $ownElement schlägt $oponentElement');
          } else if (ownElement.isBeatenBy(oponentElement)) {
            //Wenn eigenes Element von Gegner-Element geschlagen wird, Spieler ein Level niedriger
            ownValue = ownCard.lowerSpeed();
            oponentValue = oponentCard.speed;
            debugPrint(
                'VSGame - Dein $ownElement wird von $oponentElement geschlagen');
          } else {
            //Kein Element schlägt das andere
            ownValue = ownCard.speed;
            oponentValue = oponentCard.speed;
            debugPrint('VSGame - Kein Vorteil für beide');
          }
      }
    }
    debugPrint('VSGame - OwnValue: $ownValue OponentValue: $oponentValue');
    if (ownValue > oponentValue) {
      ownPoints.value++;
      oponentCard.reduceLivePoints();
      debugPrint(
          'VSGame - Spieler gewinnt Runde - Punkte Spieler: ${ownPoints.value}, Punkte Gegner ${oponentPoints.value}');
      nextTurn();

      return {
        'turnresult': TurnResult.beats,
        'ownValue': ownValue,
        'oponentValue': oponentValue
      };
    } else if (ownValue < oponentValue) {
      oponentPoints.value++;
      ownCard.reduceLivePoints();
      debugPrint(
          'VSGame - Gegner gewinnt Runde - Punkte Spieler: ${ownPoints.value}, Punkte Gegner ${oponentPoints.value}');
      nextTurn();
      return {
        'turnresult': TurnResult.beaten,
        'ownValue': ownValue,
        'oponentValue': oponentValue
      };
    } else {
      debugPrint(
          'VSGame - Keiner gewinnt Runde - Punkte Spieler: ${ownPoints.value}, Punkte Gegner ${oponentPoints.value}');
      nextTurn();
      return {
        'turnresult': TurnResult.draw,
        'ownValue': ownValue,
        'oponentValue': oponentValue
      };
    }
  }

  bool firstTurn() {
    return Random().nextBool();
  }

  String printCardDecks() {
    return ownUser.printCardDeck() + oponent.printCardDeck();
  }
}
