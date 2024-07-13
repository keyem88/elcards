import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/models/card_attributes.dart';
import 'package:myapp/models/card_element.dart';
import 'package:myapp/models/card_level.dart';

void main() {
  group('CardAttribute', () {
    test('Die Klasse CardAttribute sollte eine Liste von Attributen enthalten', () {
      expect(CardAttribute.attributes, isNotEmpty);
    });

    test('Jedes Attribut sollte die Schlüssel "attack", "defense" und "speed" enthalten', () {
      for (final attribute in CardAttribute.attributes) {
        expect(attribute.containsKey('attack'), isTrue);
        expect(attribute.containsKey('defense'), isTrue);
        expect(attribute.containsKey('speed'), isTrue);
      }
    });

    test('Der Name der Karte vom Element Ground mit der Nummer 1 sollte Erdbeben-Titan sein', (){
      final cardAttribute = CardAttribute();
      final name = cardAttribute.getName(CardElement.ground, 1);
      expect(name, 'Erdbeben-Titan');
    });

    group('CardLevel.random()', () {
    test('sollte ein CardLevel zurückgeben', () {
      final level = CardLevel.random();
      expect(level, isA<CardLevel>());
    });
    test('sollte die erwartete Wahrscheinlichkeitsverteilung haben', () {
      const iterations = 10000;
      var bronzeCount = 0;
      var silverCount = 0;
      var goldCount = 0;
      var diamondCount = 0;
      for (var i = 0; i < iterations; i++) {
        final level = CardLevel.random();
        switch (level) {
          case CardLevel.bronze:
            bronzeCount++;
            break;
          case CardLevel.silver:
            silverCount++;
            break;
          case CardLevel.gold:
            goldCount++;
            break;
          case CardLevel.diamond:
            diamondCount++;
            break;
        }
      }
      final bronzeProbability = bronzeCount / iterations;
      debugPrint('bronzeProbability: $bronzeProbability');
      final silverProbability = silverCount / iterations;
      debugPrint('silverProbability: $silverProbability');
      final goldProbability = goldCount / iterations;
      debugPrint('goldProbability: $goldProbability');
      final diamondProbability = diamondCount / iterations;
      debugPrint('diamondProbability: $diamondProbability');
      expect(bronzeProbability, closeTo(0.5, 0.05));
      expect(silverProbability, closeTo(0.3, 0.05));
      expect(goldProbability, closeTo(0.15, 0.05));
      expect(diamondProbability, closeTo(0.05, 0.05));
    });
  });
group('CardAttribute.getRandomIndex()', () {
    test('sollte einen Index innerhalb des gültigen Bereichs zurückgeben', () {
      final index = CardAttribute.getRandomIndex();
      expect(index, greaterThanOrEqualTo(0));
      expect(index, lessThan(CardAttribute.attributes.length));
    });
    test('sollte die erwartete Wahrscheinlichkeitsverteilung haben', () {
      const iterations = 10000;
      final indexCounts = List<int>.filled(CardAttribute.attributes.length, 0);
      for (var i = 0; i < iterations; i++) {
        final index = CardAttribute.getRandomIndex();
        indexCounts[index]++;
      }
      // Überprüfe, ob Indizes mit niedrigeren Attributsummen häufiger vorkommen
      for (var i = 0; i < CardAttribute.attributes.length - 1; i++) {
        final sum1 = CardAttribute.attributes[i]['attack']! +
            CardAttribute.attributes[i]['defense']! +
            CardAttribute.attributes[i]['speed']!;
        final sum2 = CardAttribute.attributes[i + 1]['attack']! +
            CardAttribute.attributes[i + 1]['defense']! +
            CardAttribute.attributes[i + 1]['speed']!;
        if (sum1 < sum2) {
          expect(indexCounts[i], greaterThan(indexCounts[i + 1]));
        }
      }
    });
  });
    // Füge weitere Tests hinzu, um spezifische Eigenschaften oder Methoden der Klasse CardAttribute zu testen.
    // Zum Beispiel könntest du testen, ob die Werte für "attack", "defense" und "speed" innerhalb eines bestimmten Bereichs liegen.
  });
}
