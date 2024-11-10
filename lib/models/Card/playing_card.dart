import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/models/Card/card_attributes.dart';
import 'package:myapp/models/Card/card_element.dart';
import 'package:myapp/models/Card/card_level.dart';

class PlayingCard {
  static final _random = Random();

  CardElement cardElement;
  CardLevel cardLevel;
  int cardNumber;
  bool inCardSet = false;
  Rx<bool> selectedForTurn = false.obs;
  late int attack;
  late int defense;
  late int speed;
  late int maxLivePoints;
  late int livePoints;
  late String name;
  late String description;

  PlayingCard(this.cardElement, this.cardLevel, this.cardNumber) {
    double multiplicator = cardLevel.multiplicator;
    attack =
        (CardAttribute.attributes[cardNumber - 1]['attack']! * multiplicator)
            .ceil();
    defense =
        (CardAttribute.attributes[cardNumber - 1]['defense']! * multiplicator)
            .ceil();
    speed = (CardAttribute.attributes[cardNumber - 1]['speed']! * multiplicator)
        .ceil();
    maxLivePoints = cardLevel.maxLivePoints;
    livePoints = maxLivePoints;
    name = CardAttribute().getName(cardElement, cardNumber);
    description = CardAttribute().getDescription(cardElement, cardNumber);
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

  int get valency {
    return attack + defense + speed;
  }

  int lowerAttack() {
    int lowerAttackValue = (CardAttribute.attributes[cardNumber - 1]
                ['attack']! *
            cardLevel.lowerMultiplicator)
        .ceil();
    debugPrint('Normal Attack Value: $attack');
    debugPrint('Lower Attack Value: $lowerAttackValue');
    return lowerAttackValue;
  }

  int lowerDefense() {
    int lowerDefenseValue = (CardAttribute.attributes[cardNumber - 1]
                ['defense']! *
            cardLevel.lowerMultiplicator)
        .ceil();
    debugPrint('Normal Defense Value: $defense');
    debugPrint('Lower Defense Value: $lowerDefenseValue');
    return lowerDefenseValue;
  }

  int lowerSpeed() {
    int lowerSpeedValue = (CardAttribute.attributes[cardNumber - 1]['speed']! *
            cardLevel.lowerMultiplicator)
        .ceil();
    debugPrint('Normal Speed Value: $speed');
    debugPrint('Lower Speed Value: $lowerSpeedValue');
    return lowerSpeedValue;
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

  void reduceLivePoints() {
    if (livePoints > 0) {
      livePoints--;
    }
  }

  @override
  String toString() {
    return '$name - $cardElement - $cardLevel - A: $attack, D: $defense, S:$speed';
  }
}
