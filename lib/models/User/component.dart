import 'dart:convert';

import 'package:myapp/models/Card/playing_card.dart';

class ElCardsComponent {
  final String userID;
  final List<PlayingCard?> cardDeck;

  ElCardsComponent(this.userID, this.cardDeck);

  factory ElCardsComponent.fromMap(Map<String, dynamic> map) {
    List<PlayingCard?> cardDeck = [];

    for (var element in map['cards']) {
      cardDeck.add(
          PlayingCard(element['element'], element['level'], element['number']));
    }
    return ElCardsComponent(
      map['userID'],
      cardDeck,
    );
  }
}
