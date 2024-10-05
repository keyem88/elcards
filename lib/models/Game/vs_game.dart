import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/models/User/component.dart';
import 'package:myapp/models/User/user.dart';
import 'package:myapp/utils/constants/app_constants.dart';

class VSGame {
  late String id;
  final ElCardsUser ownUser;
  late ElCardsOponent oponent;
  late bool ownTurn;
  bool active = true;
  int turn = 0;
  int ownPoints = 0;
  int oponentPoints = 0;
  Map<String, dynamic> turnData = {
    'ownCardIndex': null,
    'oponentCardIndex': null,
    'gameAction': null
  };

  VSGame(
    this.ownUser,
  ) {
    ownTurn = firstTurn();
    debugPrint('VSGame - created');
    debugPrint(
        ownTurn ? 'VSGame - Spieler beginnt' : 'VSGame - Gegner beginnt');
  }

  factory VSGame.joinGame(
      ElCardsUser ownUser, ElCardsOponent oponent, bool ownTurn) {
    VSGame game = VSGame(ownUser);
    game.oponent = oponent;
    game.ownTurn = ownTurn;
    debugPrint('VSGame - Spiel beigetreten');
    return game;
  }

  void setOwnCardIndex(int index) {
    turnData['ownCardIndex'] = index;
  }

  void setOponentCardIndex(int index) {
    turnData['oponentCardIndex'] = index;
  }

  void setGameAction(int index) {
    turnData['gameAction'] = ActionType.values[index];
  }

  int? getOwnCardIndex() {
    return turnData['ownCardIndex'];
  }

  int? getOponentCardIndex() {
    return turnData['oponentCardIndex'];
  }

  ActionType? getActionType() {
    return turnData['gameAction'];
  }

  void nextTurn() {
    //Wenn ein Spieler 3 Punkte erreicht, ist das Spiel beendet
    if (ownPoints >= 3 || oponentPoints >= 3) {
      active = false;
      debugPrint('VSGame - Ein Spieler hat gewonnen, Spiel beendet');
      return;
    }
    //Eine Runde weiter
    turn++;
    debugPrint('VSGame - Neue Runde ($turn)');
    //Wenn 5 Runden gespielt, dann ist Spiel beendet
    if (turn > 5) {
      active = false;
      debugPrint('VSGame - 5 Runden gespielt, Spiel beendet');
    }
  }

  TurnResult calculateTurn(
      int ownCard, int oponentCard, ActionType actionType) {
    int ownValue;
    int oponentValue;
    switch (actionType) {
      case ActionType.attack:
        debugPrint('VSGame - Angriff gewählt');
        //Es wird selbst "Attack" gewählt
        if (ownUser.cardDeck[ownCard]!.cardElement
            .beats(oponent.cardDeck[oponentCard]!.cardElement)) {
          //eigenes Element schlägt Gegner-Element
          debugPrint(
              'VSGame - ${ownUser.cardDeck[ownCard]!.cardElement} schlägt ${oponent.cardDeck[oponentCard]!.cardElement}, Gegner im Nachteil');
          ownValue = ownUser.cardDeck[ownCard]!.attack;
          oponentValue = oponent.cardDeck[oponentCard]!
              .lowerAttack(); //Level Gegner eins niedriger
        } else if (ownUser.cardDeck[ownCard]!.cardElement
            .isBeatenBy(oponent.cardDeck[oponentCard]!.cardElement)) {
          //Gegner-Element schlägt eigenes Element
          //eigenes Level eins niedriger
          debugPrint(
              'VSGame - ${oponent.cardDeck[ownCard]!.cardElement} schlägt ${ownUser.cardDeck[oponentCard]!.cardElement}, Spieler im Nachteil');
          ownValue = ownUser.cardDeck[ownCard]!.lowerAttack();
          oponentValue = oponent
              .cardDeck[oponentCard]!.attack; //Level Gegner eins niedriger
        } else {
          //Keine Element-Vorteile/Nachteile
          //Level unverändert
          debugPrint('VSGame - Keine Element-Vor-/oder Nachteile');
          ownValue = ownUser.cardDeck[ownCard]!.attack;
          oponentValue = oponent.cardDeck[oponentCard]!.attack;
        }
        break;
      case ActionType.defend:
        debugPrint('VSGame - Verteidigung gewählt');
        //Es wird selbst "Defend" gewählt
        if (ownUser.cardDeck[ownCard]!.cardElement
            .beats(oponent.cardDeck[oponentCard]!.cardElement)) {
          //eigenes Element schlägt Gegner-Element
          debugPrint(
              'VSGame - ${ownUser.cardDeck[ownCard]!.cardElement} schlägt ${oponent.cardDeck[oponentCard]!.cardElement}, Gegner im Nachteil');
          ownValue = ownUser.cardDeck[ownCard]!.defense;
          oponentValue = oponent.cardDeck[oponentCard]!
              .lowerDefense(); //Level Gegner eins niedriger
        } else if (ownUser.cardDeck[ownCard]!.cardElement
            .isBeatenBy(oponent.cardDeck[oponentCard]!.cardElement)) {
          //Gegner-Element schlägt eigenes Element
          //eigenes Level eins niedriger
          debugPrint(
              'VSGame - ${oponent.cardDeck[ownCard]!.cardElement} schlägt ${ownUser.cardDeck[oponentCard]!.cardElement}, Spieler im Nachteil');
          ownValue = ownUser.cardDeck[ownCard]!.lowerDefense();
          oponentValue = oponent
              .cardDeck[oponentCard]!.defense; //Level Gegner eins niedriger
        } else {
          //Keine Element-Vorteile/Nachteile
          //Level unverändert
          debugPrint('VSGame - Keine Element-Vor-/oder Nachteile');
          ownValue = ownUser.cardDeck[ownCard]!.defense;
          oponentValue = oponent.cardDeck[oponentCard]!.defense;
        }
        break;
      case ActionType.escape:
        debugPrint('VSGame - Flucht gewählt');
        //Es wird selbst "Escape" gewählt
        if (ownUser.cardDeck[ownCard]!.cardElement
            .beats(oponent.cardDeck[oponentCard]!.cardElement)) {
          //eigenes Element schlägt Gegner-Element
          debugPrint(
              'VSGame - ${ownUser.cardDeck[ownCard]!.cardElement} schlägt ${oponent.cardDeck[oponentCard]!.cardElement}, Gegner im Nachteil');
          ownValue = ownUser.cardDeck[ownCard]!.speed;
          oponentValue = oponent.cardDeck[oponentCard]!
              .lowerSpeed(); //Level Gegner eins niedriger
        } else if (ownUser.cardDeck[ownCard]!.cardElement
            .isBeatenBy(oponent.cardDeck[oponentCard]!.cardElement)) {
          //Gegner-Element schlägt eigenes Element
          //eigenes Level eins niedriger
          debugPrint(
              'VSGame - ${oponent.cardDeck[ownCard]!.cardElement} schlägt ${ownUser.cardDeck[oponentCard]!.cardElement}, Spieler im Nachteil');
          ownValue = ownUser.cardDeck[ownCard]!.lowerSpeed();
          oponentValue = oponent
              .cardDeck[oponentCard]!.speed; //Level Gegner eins niedriger
        } else {
          //Keine Element-Vorteile/Nachteile
          //Level unverändert
          debugPrint('VSGame - Keine Element-Vor-/oder Nachteile');
          ownValue = ownUser.cardDeck[ownCard]!.speed;
          oponentValue = oponent.cardDeck[oponentCard]!.speed;
        }
        break;
      default:
        debugPrint('VSGame - Fehler - Default im Switch');
        ownValue = 0;
        oponentValue = 0;
    }
    if (ownValue > oponentValue) {
      ownPoints++;
      debugPrint(
          'VSGame - Spieler gewinnt Runde - Punkte Spieler: $ownPoints, Punkte Gegner $oponentPoints');
      nextTurn();

      return TurnResult.beats;
    } else if (ownValue < oponentValue) {
      oponentPoints++;
      debugPrint(
          'VSGame - Gegner gewinnt Runde - Punkte Spieler: $ownPoints, Punkte Gegner $oponentPoints');
      nextTurn();
      return TurnResult.beaten;
    } else {
      debugPrint(
          'VSGame - Keiner gewinnt Runde - Punkte Spieler: $ownPoints, Punkte Gegner $oponentPoints');
      nextTurn();
      return TurnResult.draw;
    }
  }

  bool firstTurn() {
    return Random().nextBool();
  }
}
