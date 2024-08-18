import 'dart:math';

import 'package:myapp/database/card_names.dart';
import 'package:myapp/models/Card/card_element.dart';

class CardAttribute {
  static List<Map<String, int>> attributes = [
    {'attack': 10, 'defense': 10, 'speed': 10},
    {'attack': 10, 'defense': 20, 'speed': 10},
    {'attack': 10, 'defense': 10, 'speed': 20},
    {'attack': 20, 'defense': 10, 'speed': 10},
    {'attack': 10, 'defense': 30, 'speed': 10},
    {'attack': 10, 'defense': 20, 'speed': 20},
    {'attack': 10, 'defense': 10, 'speed': 30},
    {'attack': 20, 'defense': 20, 'speed': 10},
    {'attack': 20, 'defense': 10, 'speed': 20},
    {'attack': 30, 'defense': 10, 'speed': 10},
    {'attack': 10, 'defense': 30, 'speed': 20},
    {'attack': 10, 'defense': 20, 'speed': 30},
    {'attack': 20, 'defense': 30, 'speed': 10},
    {'attack': 20, 'defense': 20, 'speed': 20},
    {'attack': 20, 'defense': 10, 'speed': 30},
    {'attack': 30, 'defense': 20, 'speed': 10},
    {'attack': 30, 'defense': 10, 'speed': 20},
    {'attack': 10, 'defense': 30, 'speed': 30},
    {'attack': 20, 'defense': 30, 'speed': 20},
    {'attack': 20, 'defense': 20, 'speed': 30},
    {'attack': 30, 'defense': 30, 'speed': 10},
    {'attack': 30, 'defense': 20, 'speed': 20},
    {'attack': 30, 'defense': 10, 'speed': 30},
    {'attack': 20, 'defense': 30, 'speed': 30},
    {'attack': 30, 'defense': 30, 'speed': 20},
    {'attack': 30, 'defense': 20, 'speed': 30},
    {'attack': 30, 'defense': 30, 'speed': 30},
  ];

  static int getRandomIndex() {
    // Berechne die Summe aller Attributwerte für jedes Element in der Liste
    final sums = attributes
        .map((attr) => attr['attack']! + attr['defense']! + attr['speed']!)
        .toList();
    // Berechne die Gesamt-Summe aller Attributwerte
    final totalSum = sums.reduce((a, b) => a + b);
    // Erstelle eine Liste mit den invertierten Wahrscheinlichkeiten (höhere Summe -> geringere Wahrscheinlichkeit)
    final invertedProbabilities = sums.map((sum) => totalSum - sum).toList();
    // Berechne die Gesamt-Summe der invertierten Wahrscheinlichkeiten
    final totalInvertedProbability =
        invertedProbabilities.reduce((a, b) => a + b);
    // Generiere eine Zufallszahl zwischen 0 und der Gesamt-Summe der invertierten Wahrscheinlichkeiten
    final randomValue = Random().nextDouble() * totalInvertedProbability;
    // Finde den Index des Elements, dessen invertierte Wahrscheinlichkeit den Zufallswert überschreitet
    var cumulativeProbability = 0.0;
    for (var i = 0; i < invertedProbabilities.length; i++) {
      cumulativeProbability += invertedProbabilities[i];
      if (randomValue < cumulativeProbability) {
        return i;
      }
    }
    // Sollte eigentlich nie erreicht werden, aber zur Sicherheit den letzten Index zurückgeben
    return invertedProbabilities.length - 1;
  }

  String getName(CardElement element, int cardNumber) {
    return CardNames.getName(element, cardNumber);
  }

  String getDescription(CardElement element, int cardNumber) {
    return CardNames.getDescription(element, cardNumber);
  }
}
