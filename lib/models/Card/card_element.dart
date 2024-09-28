import 'dart:math';

import 'package:flutter/material.dart';

enum CardElement {
  fire(1),
  water(2),
  air(3),
  ground(4);

  final int internalRepresentation;

  const CardElement(this.internalRepresentation);

  factory CardElement.random() {
    final random = Random();
    return values[random.nextInt(values.length)];
  }

  factory CardElement.byInt(int value) {
    return values[value - 1];
  }

  String get asString {
    switch (this) {
      case CardElement.fire:
        return 'Fire';
      case CardElement.water:
        return 'Water';
      case CardElement.air:
        return 'Air';
      case CardElement.ground:
        return 'Ground';
    }
  }

  IconData get asIcon {
    switch (this) {
      case CardElement.fire:
        return Icons.local_fire_department;
      case CardElement.water:
        return Icons.water_drop;
      case CardElement.air:
        return Icons.air;
      case CardElement.ground:
        return Icons.grass;
    }
  }

  CardElement lowerElement() {
    switch (this) {
      case CardElement.fire:
        return CardElement.ground;
      case CardElement.ground:
        return CardElement.air;
      case CardElement.air:
        return CardElement.water;
      case CardElement.water:
        return CardElement.fire;
    }
  }

  CardElement higherElement() {
    switch (this) {
      case CardElement.ground:
        return CardElement.fire;
      case CardElement.fire:
        return CardElement.water;
      case CardElement.water:
        return CardElement.air;
      case CardElement.air:
        return CardElement.ground;
    }
  }

  bool beats(CardElement otherElement) {
    //Fire beats Ground
    //Water beats Fire
    //Air beats Water
    //Ground beats Air
    switch (this) {
      case CardElement.fire:
        return otherElement == CardElement.ground;
      case CardElement.ground:
        return otherElement == CardElement.air;
      case CardElement.air:
        return otherElement == CardElement.water;
      case CardElement.water:
        return otherElement == CardElement.fire;
    }
  }

  bool isBeatenBy(CardElement otherElement) {
    //Ground is beaten by Fire
    //Fire is beaten by Water
    //Water is beaten by Air
    //Air is beaten by Ground
    switch (this) {
      case CardElement.ground:
        return otherElement == CardElement.fire;
      case CardElement.fire:
        return otherElement == CardElement.water;
      case CardElement.water:
        return otherElement == CardElement.air;
      case CardElement.air:
        return otherElement == CardElement.ground;
    }
  }
}
