import 'package:flutter/foundation.dart';

import '../models/Card/card_element.dart';

class CardNames {
  static Map<String, String> namesFire = {
    "Infernaler Feuerdämon":
        "Ein Wesen, geboren aus den tiefsten Flammen der Hölle, dessen Feuer niemals erlischt.",
    "Vulkanischer Drachenmeister":
        "Er ruft die Macht der Vulkane herbei, um feuerspeiende Drachen zu beschwören.",
    "Glühender Phönix der Wiedergeburt":
        "Aus seiner Asche steigt er empor, jedes Mal mächtiger als zuvor.",
    "Lavaschlange der Zerstörung":
        "Schlängelt sich durch glühende Magmaströme und hinterlässt verbrannte Erde.",
    "Flammenherrscher des Äthers":
        "Gebieter über die feurigen Winde des Äthers, die in jedem Kampf lodern.",
    "Feuersturm-Sphinx":
        "Diese Sphinx bewacht ein uraltes Rätsel, dessen Lösung in den Flammen verborgen liegt.",
    "Magmabrut des Infernos":
        "Entstanden aus den kochenden Tiefen der Erde, verbreitet sie Angst und Schrecken.",
    "Glutkaiser des Chaos":
        "Ein Kaiser, der mit seinen Flammen das Chaos regiert und alles in Asche verwandelt.",
    "Flammenschildkröte der Ewigkeit":
        "Ihre Panzerung ist so heiß wie Lava und unzerstörbar, ein Symbol der Unvergänglichkeit.",
    "Brandfürst der Finsternis":
        "Er herrscht über ein Reich ewiger Nacht, in dem nur seine Flammen leuchten.",
    "Lavagolem der Verzweiflung":
        "Er lebt weit unter der Erde in kleinen Lavaseen und zehrt von der Verzweiflung, welche er bei seinen Gegnern hinterlässt.",
    "Flammenzorn-Elementar":
        "Ein wütender Geist, der alles niederbrennt, was sich ihm in den Weg stellt.",
    "Feuerblitz-Hexer":
        "Beherrscht die Macht, zerstörerische Feuerblitze auf seine Feinde herabzurufen.",
    "Höllenflügel des Zorns":
        "Mit Flügeln aus Feuer schwingt er sich in die Lüfte, um seinen Zorn zu entfesseln.",
    "Drachenfeuer des Urknalls":
        "Ein Relikt aus der Zeit des Urknalls, dessen Feuer das Universum geformt hat.",
    "Vulkanische Furie der Vergeltung":
        "Ihre Rache ist gnadenlos, wie ein Vulkan, der urplötzlich ausbricht.",
    "Feueropal-Phantom":
        "Ein schillerndes Wesen, dessen glühende Opale das Feuer der Vergangenheit reflektieren.",
    "Glutwächter der Asche":
        "Er bewacht die letzten Überreste längst vergessener Feuer.",
    "Flammenherz des Krieges":
        "Mit einem Herzen aus Flammen, kämpft er mit unendlicher Leidenschaft.",
    "Infernaler Zerstörer":
        "Ein Krieger, der mit seinem Feuer alles dem Boden gleichmacht.",
    "Feuerschlund der Verdammnis":
        "Sein brennender Atem schickt jene, die ihn sehen, direkt in die Verdammnis.",
    "Vulkanische Hydra der Vernichtung":
        "Jeder ihrer Köpfe spuckt Flammen, die alles in ihrem Weg vernichten.",
    "Feueratem der Apocalypse":
        "Der Feueratem, der am Ende der Zeiten alles verschlingen wird.",
    "Glutflamme des Untergangs":
        "Ihr Licht kündigt den bevorstehenden Untergang an.",
    "Inferno-Gigant der Zerberus":
        "Ein gigantisches Wesen, das das Feuer der Unterwelt hütet.",
    "Phönixflamme der Unsterblichkeit":
        "Die Flamme, die niemals erlischt, Symbol für unendliches Leben.",
    "Feuerbringer der Verheerung":
        "Ein Wesen, das den Flammen den Weg ebnet und Verheerung zurücklässt."
  };

  static Map<String, String> namesWater = {
    "Mystischer Meereszauberer":
        "Ein uralter Magier, der die Geheimnisse der tiefsten Meere beherrscht.",
    "Sirene der tiefen Wellen":
        "Mit ihrem betörenden Gesang lockt sie ahnungslose Seefahrer in die Tiefe.",
    "Nebelgeist des Ozeans":
        "Ein geisterhaftes Wesen, das im Nebel über dem Wasser schwebt und Angst verbreitet.",
    "Kristalliner Aquadämon":
        "Ein Dämon aus kristallklarem Wasser, dessen Körper unzerbrechlich ist.",
    "Perlenglanz-Nymphen":
        "Diese Nymphen tanzen im Mondlicht und bewachen die wertvollsten Perlen der Ozeane.",
    "Flutwandler der Dunkelheit":
        "Er kontrolliert die Fluten bei Nacht und bringt das Unheil mit den Wellen.",
    "Atlantis-Wächter":
        "Ein mächtiger Krieger, der die versunkene Stadt Atlantis vor Eindringlingen schützt.",
    "Quell der Ewigkeit":
        "Eine magische Quelle, deren Wasser ewiges Leben verleiht.",
    "Gezeitenmeisterin der Stürme":
        "Sie kontrolliert die Gezeiten und entfesselt gewaltige Stürme auf See.",
    "Schleier der Meereskönigin":
        "Ein geheimnisvoller Schleier, der die wahre Macht der Meereskönigin verbirgt.",
    "Azurblauer Wassergeist":
        "Ein sanfter Geist, der durch azurblaue Strömungen wandert und Ruhe bringt.",
    "Tiefseeschrecken":
        "Ein furchterregendes Ungeheuer, das in den dunkelsten Tiefen lauert.",
    "Aquamarin-Drache":
        "Ein majestätischer Drache, dessen Schuppen in allen Blau- und Grüntönen schimmern.",
    "Delphinorakel":
        "Ein weiser Delphin, der die Geheimnisse der Meere kennt und prophezeit.",
    "Wasserfall der Verzauberung":
        "Ein magischer Wasserfall, der jeden verzaubert, der ihn erblickt.",
    "Ätherische Seetänzerin":
        "Eine zarte Tänzerin, die auf den Wellen tanzt und die Herzen der Sterblichen erobert.",
    "Quallenhexe des Abyss":
        "Eine finstere Hexe, die im Abgrund lebt und ihre Gegner mit giftigen Tentakeln bezwingt.",
    "Perlenschlund-Hydra":
        "Eine mehrköpfige Hydra, die sich von den wertvollsten Perlen ernährt.",
    "Wellenrufer des Unheils":
        "Ein düsterer Prophet, der mit seinen Wellen Katastrophen vorhersagt und heraufbeschwört.",
    "Eiskalte Nixe":
        "Eine Nixe mit einem Herzen aus Eis, die ihre Gegner in kalten Umarmungen erstarren lässt.",
    "Korallenbeschwörer":
        "Er kann Korallen zum Leben erwecken und sie in tödliche Waffen verwandeln.",
    "Ewige Ozeanseele":
        "Ein geheimnisvolles Wesen, das die unergründlichen Tiefen des Ozeans bewacht.",
    "Tiefsee-Titan":
        "Ein gewaltiges Wesen, das in den tiefsten Gräben des Ozeans ruht und auf seinen Einsatz wartet.",
    "Dampfender Wasserschleier":
        "Ein Nebel, der aus heißem Dampf besteht und Gegner verwirrt.",
    "Seemonster der Urzeit":
        "Ein uraltes Wesen, das seit Äonen im Ozean schlummert und auf Beute wartet.",
    "Salzige Seherin der Prophezeiung":
        "Eine Seherin, die aus dem Salz des Meeres Prophezeiungen liest.",
    "Nebelwesen der Unergründlichkeit":
        "Ein Wesen, das aus Nebel besteht und unberechenbar in der Tiefe erscheint.",
  };

  static Map<String, String> namesGround = {
    "Erdbeben-Titan":
        "Ein gigantisches Wesen, das mit jedem Schritt die Erde zum Beben bringt.",
    "Wurzelwanderer des Urwalds":
        "Er bewegt sich lautlos durch den Urwald, verbunden mit den ältesten Wurzeln der Welt.",
    "Steinkoloss der Ewigkeit":
        "Ein uralter Golem, dessen Körper aus den härtesten Steinen des Gebirges besteht.",
    "Bergdrache der Titanen":
        "Ein mächtiger Drache, der tief in den Bergen haust und über das Land wacht.",
    "Erdmutter der Schöpfung":
        "Die Urkraft der Erde selbst, aus der alles Leben entspringt.",
    "Moosgeist des Verborgenen":
        "Ein flüsternder Geist, der sich im Moos versteckt und die Geheimnisse des Waldes hütet.",
    "Kristallwächter des Abgrunds":
        "Ein Wächter aus reinem Kristall, der den Eingang zum tiefsten Abgrund bewacht.",
    "Gigantischer Felsenhüter":
        "Ein uralter Riese, der die heiligen Berge gegen Eindringlinge verteidigt.",
    "Dornenbeschwörer des Dschungels":
        "Er ruft die Dornen der Wildnis herbei, um seine Feinde zu überwältigen.",
    "Felsentroll der Uralten":
        "Ein massiver Troll, der seit Urzeiten in den tiefsten Höhlen haust.",
    "Erdschildkröte der Weisheit":
        "Eine weise Schildkröte, die das uralte Wissen der Erde in sich trägt.",
    "Baumkrieger der Ahnen":
        "Ein tapferer Krieger, geboren aus den ältesten Bäumen des Waldes.",
    "Höhlenbewahrer des Geheimnisses":
        "Er bewacht die tiefen Höhlen, in denen uralte Geheimnisse verborgen liegen.",
    "Steinadler der Freiheit":
        "Ein majestätischer Adler, der hoch über die Berge fliegt und die Freiheit liebt.",
    "Naturgeist der Harmonie":
        "Ein friedvoller Geist, der die Balance zwischen allen Lebewesen aufrechterhält.",
    "Treibholz-Titan des Ozeans":
        "Ein titanisches Wesen, das aus uraltem Treibholz besteht und die Küsten bewacht.",
    "Erzdrache der Tiefe":
        "Ein Drache, der tief im Inneren der Erde lebt und wertvolles Erz bewacht.",
    "Erdgeist des Gleichgewichts":
        "Ein uralter Geist, der dafür sorgt, dass die Erde in Gleichgewicht bleibt.",
    "Sanddünen-Schrecken":
        "Ein Wesen, das in den endlosen Wüsten lebt und in den Sandstürmen lauert.",
    "Kristallauge des Felsens":
        "Ein allsehendes Auge, das tief im Inneren eines uralten Felsens ruht.",
    "Hüter der Erdkraft":
        "Ein Beschützer der reinen Kraft der Erde, die in den tiefsten Schichten verborgen liegt.",
    "Wurzelwächter des Lebens":
        "Er beschützt die Wurzeln, aus denen das Leben selbst entspringt.",
    "Sandsturm-Sphinx":
        "Eine mystische Sphinx, die in den Sandstürmen der Wüste Rätsel aufgibt.",
    "Berggeist der Erhabenheit":
        "Ein erhabener Geist, der in den höchsten Gipfeln der Berge thront.",
    "Riesenkraken der Tiefen":
        "Ein gewaltiger Kraken, der in den dunkelsten Tiefen des Ozeans auf Beute wartet.",
    "Wüstenwächter der Stille":
        "Ein stiller Wächter, der über die unendliche Weite der Wüste wacht.",
    "Erdverbündeter des Lebenskreises":
        "Ein treuer Begleiter, der den ewigen Kreislauf von Leben und Tod schützt."
  };

  static Map<String, String> namesAir = {
    "Ätherischer Wolkenzauberer":
        "Ein weiser Magier, der die Wolken formt und das Wetter kontrolliert.",
    "Luftschlangen-Djinn":
        "Ein mächtiger Djinn, der in den Winden tanzt und Stürme entfesselt.",
    "Sturmhexe der Wirbelwinde":
        "Eine Hexe, die die Macht hat, Wirbelwinde heraufzubeschwören und alles zu verwüsten.",
    "Wolkenkönig des Himmels":
        "Der Herrscher über die Wolkenreiche, unangefochten in den höchsten Lüften.",
    "Wirbelsturm-Phantom":
        "Ein gespenstisches Wesen, das unsichtbar in Wirbelstürmen tobt und Schrecken verbreitet.",
    "Ätherdrache der Lüfte":
        "Ein majestätischer Drache, der durch die Ätherströmungen des Himmels gleitet.",
    "Nebelschwinge des Geistes":
        "Eine mystische Kreatur, die im Nebel verschwindet und lautlos zuschlägt.",
    "Zephyrgefährte des Schicksals":
        "Ein luftiger Begleiter, der das Schicksal durch sanfte Windstöße lenkt.",
    "Schwingen des Äthers":
        "Unermüdliche Flügel, die den Äther durchqueren und überirdische Kraft verleihen.",
    "Luftgeist der Unendlichkeit":
        "Ein ewiger Geist, der durch die Winde weht und nie vergeht.",
    "Wirbelnde Harpyie der Morgenröte":
        "Eine wilde Harpyie, die im ersten Licht des Tages herabstürzt.",
    "Ätherischer Falkenmeister":
        "Ein Meister der Falken, der mit seinen geflügelten Verbündeten die Lüfte beherrscht.",
    "Wolkenwandrer des Himmels":
        "Ein Wanderer, der auf den Wolken reist und die Geheimnisse der Lüfte kennt.",
    "Sturmrufer des Chaos":
        "Ein Bote des Chaos, der mit einem einzigen Ruf gewaltige Stürme entfacht.",
    "Luftschleier-Nymphe":
        "Eine zarte Nymphe, die im Schleier des Windes tanzt und Unheil bringt.",
    "Windtänzerin der Freiheit":
        "Eine Tänzerin, die mit den Winden tanzt und Freiheit in die Lüfte trägt.",
    "Sturmphönix der Erleuchtung":
        "Ein Phönix, der im Äther brennt und mit seinem Licht Weisheit bringt.",
    "Nebelkönig der Dämmerung":
        "Ein flüchtiger Geist, der in der Dämmerung erscheint und im Nebel verschwindet.",
    "Wirbelwindtitan der Zeit":
        "Ein gigantischer Titan, der die Zeit durch mächtige Windstöße beeinflusst.",
    "Himmelsdrache der Erleuchtung":
        "Ein erleuchteter Drache, der über den Wolken schwebt und mit Weisheit segnet.",
    "Luftgeist der Ewigkeit":
        "Ein unsterblicher Geist, der ewig durch die Lüfte wandert.",
    "Sturmschleier-Hexer":
        "Ein Hexer, der den Sturmschleier beschwört und seine Feinde darin gefangen hält.",
    "Himmelswächter der Dämmerung":
        "Ein Wächter, der das Himmelszelt beschützt, wenn die Nacht hereinbricht.",
    "Wirbelsturm-Sphinx":
        "Eine rätselhafte Sphinx, die in Wirbelstürmen erscheint und unlösbare Rätsel stellt.",
    "Wolkenherrscher des Äthers":
        "Der unangefochtene Herrscher der Wolkenreiche, der im Äther lebt.",
    "Sturmgesang-Sirene":
        "Eine Sirene, deren Gesang den Sturm ruft und Seeleute ins Verderben lockt.",
    "Stürmische Wolkenschlange":
        "Eine gigantische Schlange, die durch die Wolken gleitet und mit Blitzen zuschlägt."
  };

  static String getName(CardElement element, int cardNumber) {
    debugPrint('CardNames getName: $element $cardNumber');
    switch (element) {
      case CardElement.air:
        return namesAir.keys.elementAt(cardNumber);
      case CardElement.fire:
        return namesFire.keys.elementAt(cardNumber);
      case CardElement.ground:
        return namesGround.keys.elementAt(cardNumber);
      case CardElement.water:
        return namesWater.keys.elementAt(cardNumber);
      default:
        return 'No Name';
    }
  }

  static String getDescription(CardElement element, int cardNumber) {
    switch (element) {
      case CardElement.air:
        String name = namesAir.keys.elementAt(cardNumber);
        if (namesAir[name] != null) {
          return namesAir[name]!;
        }
      case CardElement.ground:
        String name = namesGround.keys.elementAt(cardNumber);
        if (namesGround[name] != null) {
          return namesGround[name]!;
        }
      case CardElement.water:
        String name = namesWater.keys.elementAt(cardNumber);
        if (namesWater[name] != null) {
          return namesWater[name]!;
        }
      case CardElement.fire:
        String name = namesFire.keys.elementAt(cardNumber);
        if (namesFire[name] != null) {
          return namesFire[name]!;
        }
      default:
        return 'No Description';
    }
    return 'No Description';
  }
}
