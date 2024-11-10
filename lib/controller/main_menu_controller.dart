import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/database/firebase/firestore_database.dart';

import 'package:myapp/models/User/user.dart';
import 'package:myapp/views/Cards/my_cards_view.dart';
import 'package:myapp/views/Game/card_selection_view.dart';

import 'package:myapp/views/Game/show_qr_code_view.dart';
import 'package:myapp/views/Game/scan_qr_code_view.dart';
import 'package:myapp/utils/permissions/permission_checker.dart';

import '../models/Card/playing_card.dart';
import '../widgets/cards/card_widget.dart';

class MainMenuController extends GetxController {
  ElCardsUser? user;
  var isLoading = true.obs;
  var selectedIndex = 1.obs;
  late List<Widget> pages;

  Rx<bool> fiveCardsChoosen = false.obs;

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
    if (selectedIndex.value == 1) {
      user!.resetCardDeck();
      user!.cardSet.allCardsFromDeck();
      fiveCardsChoosen.value = false;
    }
    update();
  }

  void clickOnCard(BuildContext context, int index) {
    debugPrint('clickOnCard $index');
    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent, // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, __, ___) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: CardWidget(
                card: user!.cardSet.cards[index],
              ),
            ),
          ),
        );
      },
    );
  }

  void selectCard(int index) {
    if (user!.cardSet.cards[index].inCardSet) {
      user!.cardSet.cards[index].inCardSet = false;
      user!.cardDeck.remove(user!.cardSet.cards[index]);
      user!.cardDeck.add(null);
    } else {
      PlayingCard? removedCard = user!.cardDeck.removeAt(4);
      if (removedCard != null) {
        user!.cardSet.cards[user!.cardSet.cards.indexOf(removedCard)]
            .inCardSet = false;
      }
      user!.cardDeck.insert(0, user!.cardSet.cards[index]);
      user!.cardSet.cards[index].inCardSet = true;
      debugPrint('New Card Deck: ${user!.cardDeck}');
    }
    fiveCardsChoosen.value = user!.cardDeck.every((card) => card != null);
    update();
  }

  void removeCardFromCardDeck(int index) {
    if (user!.cardDeck[index] != null) {
      PlayingCard? removedCard = user!.cardDeck.removeAt(index);
      user!.cardDeck.add(null);
      user!.cardSet.cards[user!.cardSet.cards.indexOf(removedCard!)].inCardSet =
          false;
      fiveCardsChoosen.value = (user!.cardDeck.length == 5);
      update();
    }
  }

  void clickStartOwnGameButton() async {
    debugPrint('clickJoinGameButton');
    if (await PermissionChecker.checkAllPermissions()) {
      Get.offAll(
        () => ShowQRCodeView(
          user: user!,
        ),
      );
    } else {
      Get.snackbar('Error', 'Please grant all permissions');
    }
  }

  void clickJoinGameButton() async {
    debugPrint('clickStartOwnGameButton');
    if (await PermissionChecker.checkAllPermissions()) {
      startOwnGame();
    } else {
      Get.snackbar('Error', 'Please grant all permissions');
    }
  }

  Future<void> startOwnGame() async {
    debugPrint('startOwnGame');

    Get.offAll(
      () => ScanQRCodeView(
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
