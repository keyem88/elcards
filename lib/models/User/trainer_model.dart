import 'dart:math';

import 'package:myapp/models/Card/card_set.dart';
import 'package:myapp/utils/constants/app_constants.dart';

import '../Card/playing_card.dart';

class TrainerModel {
  final CardSet cardSet = CardSet.initialCards();
  late final List<PlayingCard> cardDeck;

  TrainerModel() {
    cardDeck = cardSet.getRandomCardDeck();
  }

  PlayingCard getRandomCard() {
    Random random = Random();
    PlayingCard randomCard = cardDeck[random.nextInt(cardDeck.length)];
    while (randomCard.livePoints == 0) {
      randomCard = cardDeck[random.nextInt(cardDeck.length)];
    }
    return randomCard;
  }

  int getRandomCardIndex() {
    Random random = Random();
    int index = random.nextInt(cardDeck.length);
    while (cardDeck[index].livePoints == 0) {
      index = random.nextInt(cardDeck.length);
    }
    return index;
  }

  ActionType getRandomActionType() {
    Random random = Random();
    return ActionType.values[random.nextInt(ActionType.values.length)];
  }
}
