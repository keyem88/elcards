import 'dart:math';

import 'package:myapp/models/Card/card_attributes.dart';
import 'package:myapp/models/Card/card_element.dart';
import 'package:myapp/models/Card/card_level.dart';

class PlayingCard {
  static final _random = Random();
  
  CardElement cardElement;
  CardLevel cardLevel;
  int cardNumber;
  late int attack;
  late int defense;
  late int speed;
  late int maxLivePoints;
  late String name;



  PlayingCard(this.cardElement, this.cardLevel, this.cardNumber){
    double multiplicator = cardLevel.multiplicator;
    attack = (CardAttribute.attributes[cardNumber - 1]['attack']! * multiplicator).ceil();
    defense = (CardAttribute.attributes[cardNumber - 1]['defense']!* multiplicator).ceil();
    speed = (CardAttribute.attributes[cardNumber - 1]['speed']!* multiplicator).ceil();
    maxLivePoints = cardLevel.maxLivePoints;
    name = CardAttribute().getName(cardElement, cardNumber);
  }

    factory PlayingCard.fromJson(Map<String, dynamic> json) {
    return PlayingCard(
      CardElement.values
          .singleWhere((e) => e.internalRepresentation == json['element']),
      CardLevel.values
          .singleWhere((e) => e.internalRepresentation == json['level']),
      json['number'],
    );
  }

  factory PlayingCard.random([Random? random]) {
    random ??= _random;
    return PlayingCard(
      CardElement.random(),
      CardLevel.random(),
      CardAttribute.getRandomIndex() + 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'element': cardElement.internalRepresentation,
      'level': cardLevel.internalRepresentation,
      'number': cardNumber,
    };
  }
}
