import 'dart:math';

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

  List<String> namesWater = [
    "Mystischer Meereszauberer",
    "Sirene der tiefen Wellen",
    "Nebelgeist des Ozeans",
    "Kristalliner Aquadämon",
    "Perlenglanz-Nymphen",
    "Flutwandler der Dunkelheit",
    "Atlantis-Wächter",
    "Quell der Ewigkeit",
    "Gezeitenmeisterin der Stürme",
    "Schleier der Meereskönigin",
    "Azurblauer Wassergeist",
    "Tiefseeschrecken",
    "Aquamarin-Drache",
    "Delphinorakel",
    "Wasserfall der Verzauberung",
    "Ätherische Seetänzerin",
    "Quallenhexe des Abyss",
    "Perlenschlund-Hydra",
    "Wellenrufer des Unheils",
    "Eiskalte Nixe",
    "Korallenbeschwörer",
    "Ewige Ozeanseele",
    "Tiefsee-Titan",
    "Dampfender Wasserschleier",
    "Seemonster der Urzeit",
    "Salzige Seherin der Prophezeiung",
    "Nebelwesen der Unergründlichkeit",
  ];

  List<String> namesFire = [
    "Infernaler Feuerdämon",
    "Vulkanischer Drachenmeister",
    "Glühender Phönix der Wiedergeburt",
    "Lavaschlange der Zerstörung",
    "Flammenherrscher des Äthers",
    "Feuersturm-Sphinx",
    "Magmabrut des Infernos",
    "Glutkaiser des Chaos",
    "Flammenschildkröte der Ewigkeit",
    "Brandfürst der Finsternis",
    "Lavagolem der Verzweiflung",
    "Flammenzorn-Elementar",
    "Feuerblitz-Hexer",
    "Höllenflügel des Zorns",
    "Drachenfeuer des Urknalls",
    "Vulkanische Furie der Vergeltung",
    "Feueropal-Phantom",
    "Glutwächter der Asche",
    "Flammenherz des Krieges",
    "Infernaler Zerstörer",
    "Feuerschlund der Verdammnis",
    "Vulkanische Hydra der Vernichtung",
    "Feueratem der Apocalypse",
    "Glutflamme des Untergangs",
    "Inferno-Gigant der Zerberus",
    "Phönixflamme der Unsterblichkeit",
    "Feuerbringer der Verheerung",
  ];

  List<String> namesAir = [
    "Ätherischer Wolkenzauberer",
    "Luftschlangen-Djinn",
    "Sturmhexe der Wirbelwinde",
    "Wolkenkönig des Himmels",
    "Wirbelsturm-Phantom",
    "Ätherdrache der Lüfte",
    "Nebelschwinge des Geistes",
    "Zephyrgefährte des Schicksals",
    "Schwingen des Äthers",
    "Luftgeist der Unendlichkeit",
    "Wirbelnde Harpyie der Morgenröte",
    "Ätherischer Falkenmeister",
    "Wolkenwandrer des Himmels",
    "Sturmrufer des Chaos",
    "Luftschleier-Nymphe",
    "Windtänzerin der Freiheit",
    "Sturmphönix der Erleuchtung",
    "Nebelkönig der Dämmerung",
    "Wirbelwindtitan der Zeit",
    "Himmelsdrache der Erleuchtung",
    "Luftgeist der Ewigkeit",
    "Sturmschleier-Hexer",
    "Himmelswächter der Dämmerung",
    "Wirbelsturm-Sphinx",
    "Wolkenherrscher der Lüfte",
    "Sturmgesang-Sirene",
    "Stürmische Wolkenschlange",
  ];
  List<String> namesGround = [
    "Erdbeben-Titan",
    "Wurzelwanderer des Urwalds",
    "Steinkoloss der Ewigkeit",
    "Bergdrache der Titanen",
    "Erdmutter der Schöpfung",
    "Moosgeist des Verborgenen",
    "Kristallwächter des Abgrunds",
    "Gigantischer Felsenhüter",
    "Dornenbeschwörer des Dschungels",
    "Felsentroll der Uralten",
    "Erdschildkröte der Weisheit",
    "Baumkrieger der Ahnen",
    "Höhlenbewahrer des Geheimnisses",
    "Steinadler der Freiheit",
    "Naturgeist der Harmonie",
    "Treibholz-Titan",
    "Erzdrache der Tiefe",
    "Erdgeist des Gleichgewichts",
    "Sanddünen-Schrecken",
    "Kristallauge des Felsens",
    "Hüter der Erdkraft",
    "Wurzelwächter des Lebens",
    "Sandsturm-Sphinx",
    "Berggeist der Erhabenheit",
    "Riesenkraken der Tiefen",
    "Wüstenwächter der Stille",
    "Erdverbündeter des Lebenskreises",
  ];

  String getName(CardElement element, int cardNumber) {
    switch (element) {
      case CardElement.fire:
        return namesFire[cardNumber - 1];
      case CardElement.water:
        return namesWater[cardNumber - 1];
      case CardElement.air:
        return namesAir[cardNumber - 1];
      case CardElement.ground:
        return namesGround[cardNumber - 1];
    }
  }
}
