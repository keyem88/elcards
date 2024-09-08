import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/database/firebase/firestore_database.dart';

import 'package:myapp/models/User/user.dart';
import 'package:myapp/views/Cards/my_cards_view.dart';
import 'package:myapp/views/Game/card_selection_view.dart';

import 'package:myapp/views/Game/game_main_view.dart';
import 'package:myapp/views/Game/join_game_view.dart';
import 'package:myapp/views/Game/start_new_game_view.dart';
import 'package:myapp/utils/permissions/permission_checker.dart';

import '../models/Card/playing_card.dart';
import '../widgets/cards/card_widget.dart';

class MainMenuController extends GetxController {
  ElCardsUser? user;
  var isLoading = true.obs;
  var selectedIndex = 1.obs;
  late List<Widget> pages;

  @override
  void onInit() async {
    debugPrint('onInit');
    debugPrint(FirebaseAuth.instance.currentUser!.uid);
    debugPrint('Is Loading: ${isLoading.value.toString()}');
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1482327748.
    user = await FirestoreDatabase.getUser(
      FirebaseAuth.instance.currentUser!.uid,
    );
    pages = [
      CardSelectionView(
        controller: this,
      ),
      MyCardsView(
        controller: this,
      ),
      MyCardsView(controller: this),
    ];
    isLoading.value = false;
    debugPrint('Is Loading: ${isLoading.value.toString()}');
    super.onInit();
  }

  void onItemTapped(int index) {
    debugPrint('onItemTapped $index');
    selectedIndex.value = index;
    update();
  }

  void clickOnCard(BuildContext context, int index) {
    debugPrint('clickOnCard $index');
    showDialog(
        context: context,
        builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: CardWidget(
              card: user!.cardSet.cards[index],
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.7,
            )));
  }

  void selectCard(int index) {
    PlayingCard? removedCard = user!.cardDeck.removeAt(4);
    if (removedCard != null) {
      user!.cardSet.cards[user!.cardSet.cards.indexOf(removedCard)].inCardSet =
          false;
    }
    user!.cardDeck.insert(0, user!.cardSet.cards[index]);
    user!.cardSet.cards[index].inCardSet = true;
    debugPrint('New Card Deck: ${user!.cardDeck}');
    update();
  }

  void removeCardFromCardDeck(int index) {
    if (user!.cardDeck[index] != null) {
      PlayingCard? removedCard = user!.cardDeck.removeAt(index);
      user!.cardDeck.add(null);
      user!.cardSet.cards[user!.cardSet.cards.indexOf(removedCard!)].inCardSet =
          false;
      update();
    }
  }

  void clickJoinGameButton() async {
    debugPrint('clickJoinGameButton');
    if (await PermissionChecker.checkAllPermissions()) {
      Get.to(
        () => JoinGameView(
          user: user!,
        ),
      );
    } else {
      Get.snackbar('Error', 'Please grant all permissions');
    }
  }

  void clickStartOwnGameButton() async {
    debugPrint('clickStartOwnGameButton');
    if (await PermissionChecker.checkAllPermissions()) {
      startOwnGame();
    } else {
      Get.snackbar('Error', 'Please grant all permissions');
    }
  }

  Future<void> startOwnGame() async {
    debugPrint('startOwnGame');

    Get.to(
      () => StartNewGameView(
        user: user!,
      ),
    );
  }

  @override
  void dispose() {
    debugPrint('dispose');
    user = null;
    isLoading.value = true;
    super.dispose();
  }
}
