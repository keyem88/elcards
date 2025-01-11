import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/models/Card/card_element.dart';
import 'package:myapp/models/Card/card_level.dart';
import 'package:myapp/models/Card/playing_card.dart';

class ElCardsOponent {
  final String userID;
  final List<PlayingCard?> cardDeck;
  final int avatar;
  bool finishedTurn = false;

  ElCardsOponent(this.userID, this.cardDeck, this.avatar);

  factory ElCardsOponent.fromMap(Map<String, dynamic> map) {
    List<PlayingCard?> cardDeck = [];
    List cardData = json.decode(map['cards']);

    for (int i = 0; i < cardData.length; i++) {
      cardDeck.add(PlayingCard(CardElement.byInt(cardData[i]['element']),
          CardLevel.byInt(cardData[i]['level']), cardData[i]['number']));
    }
    debugPrint(
        "ElCardsOponent.fromMap: ${cardData} lenght: ${cardData.length}");
    return ElCardsOponent(
      map['userID'],
      cardDeck,
      map['avatar'],
    );
  }

  String printCardDeck() {
    String result = 'Oponent - Card - Deck:\n';
    for (int i = 0; i < 5; i++) {
      result = '$result${cardDeck[i]}\n';
    }
    return result;
  }
}
