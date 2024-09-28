import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/Card/card_set.dart';
import 'package:myapp/models/Card/playing_card.dart';

class ElCardsUser {
  final String userID;
  final String email;
  final CardSet cardSet;
  List<PlayingCard?> cardDeck = List.generate(
    5,
    (index) => null,
  );

  ElCardsUser(
    this.userID,
    this.email,
    this.cardSet,
  );

  void resetCardDeck() {
    for (int i = 0; i < cardDeck.length; i++) {
      cardDeck[i] = null;
    }
  }

  factory ElCardsUser.fromSnapshot(
      DocumentSnapshot userSnapshot, QuerySnapshot cardSnaphot) {
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    CardSet cardSet = CardSet.fromSnapshot(cardSnaphot);
    return ElCardsUser(
      userSnapshot.id,
      userData['email'],
      cardSet,
    );
  }

  factory ElCardsUser.fromMap(Map<String, dynamic> map) {
    return ElCardsUser(
      map['userID'],
      map['email'],
      CardSet.fromMap(map['cards']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'cards': cardSet.toMap(),
    };
  }
}
