import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/config/themes/app_colors.dart';

enum CardLevel {
  bronze(1),
  silver(2),
  gold(3),
  diamond(4);

  static const List<double> _multiplicators = [1.0, 1.3, 2.0, 4.0];

  final int internalRepresentation;

  const CardLevel(this.internalRepresentation);

  factory CardLevel.random() {
    //return Level bronze with a probability of 0.5, silver with a probability of 0.3, and gold with a probability of 0.15
    //and diamond with a probability of 0.05
    final random = Random().nextDouble();
    switch (random) {
      case <= 0.5:
        return CardLevel.bronze;
      case <= 0.8:
        return CardLevel.silver;
      case <= 0.95:
        return CardLevel.gold;
      default:
        return CardLevel.diamond;
    }
  }

  factory CardLevel.byInt(int value) {
    return values[value - 1];
  }

  // Returns a string representation of the card level.
  String get asString {
    switch (this) {
      case CardLevel.bronze:
        return 'Bronze';
      case CardLevel.silver:
        return 'Silver';
      case CardLevel.gold:
        return 'Gold';
      case CardLevel.diamond:
        return 'Diamond';
    }
  }

  // Returns a [Color] based on the card level.
  Color get asColor {
    switch (this) {
      case CardLevel.bronze:
        return AppColors.bronze;
      case CardLevel.silver:
        return AppColors.silver;
      case CardLevel.gold:
        return AppColors.gold;
      case CardLevel.diamond:
        return AppColors.diamond;
    }
  }

  String get asText {
    switch (this) {
      case CardLevel.bronze:
        return 'bronze';
      case CardLevel.silver:
        return 'silver';
      case CardLevel.gold:
        return 'gold';
      case CardLevel.diamond:
        return 'diamond';
    }
  }

  double get multiplicator {
    switch (this) {
      case CardLevel.bronze:
        return _multiplicators[0];
      case CardLevel.silver:
        return _multiplicators[1];
      case CardLevel.gold:
        return _multiplicators[2];
      case CardLevel.diamond:
        return _multiplicators[3];
    }
  }

  double get lowerMultiplicator {
    switch (this) {
      case CardLevel.bronze:
        return _multiplicators[0];
      case CardLevel.silver:
        return _multiplicators[0];
      case CardLevel.gold:
        return _multiplicators[1];
      case CardLevel.diamond:
        return _multiplicators[2];
    }
  }

  CardLevel get lowerElement {
    switch (this) {
      case CardLevel.bronze:
        return CardLevel.bronze;
      case CardLevel.silver:
        return CardLevel.bronze;
      case CardLevel.gold:
        return CardLevel.silver;
      case CardLevel.diamond:
        return CardLevel.gold;
    }
  }

  int get maxLivePoints {
    switch (this) {
      case CardLevel.bronze:
        return 1;
      case CardLevel.silver:
        return 2;
      case CardLevel.gold:
        return 3;
      case CardLevel.diamond:
        return 4;
    }
  }
}
