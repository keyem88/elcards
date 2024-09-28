import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/Card/playing_card.dart';

class CardSet {
  List<PlayingCard> cards = [];
  CardSet();

  void addCard(PlayingCard card) {
    cards.add(card);
  }

  void removeCard(PlayingCard card) {
    cards.remove(card);
  }

  void clearCards() {
    cards.clear();
  }

  void allCardsFromDeck() {
    for (PlayingCard card in cards) {
      card.inCardSet = false;
    }
  }

  factory CardSet.initialCards() {
    CardSet cardSet = CardSet();
    for (int i = 0; i <= 7; i++) {
      cardSet.addCard(PlayingCard.random());
    }
    return cardSet;
  }

  factory CardSet.fromMap(Map<String, dynamic> map) {
    CardSet cardSet = CardSet();
    for (int i = 0; i < map['cards'].length; i++) {
      cardSet.addCard(PlayingCard.fromJson(map['cards'][i]));
    }
    return cardSet;
  }

  Map<String, dynamic> toMap() {
    return {
      'cards': cards.map((card) => card.toJson()).toList(),
    };
  }

  factory CardSet.fromSnapshot(QuerySnapshot snapshot) {
    CardSet cardSet = CardSet();
    for (var card in snapshot.docs) {
      cardSet
          .addCard(PlayingCard.fromJson(card.data() as Map<String, dynamic>));
    }
    return cardSet;
  }

  String toJSON() {
    return cards.toString();
  }
}
