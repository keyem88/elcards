import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/database/firebase/firestore_database.dart';
import 'package:myapp/models/Game/challenge.dart';

import 'package:myapp/models/User/user.dart';
import 'package:myapp/views/Clans/clans_view.dart';
import 'package:myapp/views/Home/home_view.dart';
import 'package:myapp/views/MyCards/my_cards_view.dart';
import 'package:myapp/views/Game/card_selection_view.dart';

import 'package:myapp/views/VSGame/show_qr_code_view.dart';
import 'package:myapp/views/VSGame/scan_qr_code_view.dart';
import 'package:myapp/utils/permissions/permission_checker.dart';
import 'package:myapp/views/shop/shop_view.dart';

import '../models/Card/playing_card.dart';
import '../widgets/cards/card_widget.dart';

class MainMenuController extends GetxController with StateMixin {
  ElCardsUser? user;
  var isLoading = true.obs;
  var selectedIndex = 1.obs;
  late List<Widget> pages;
  var createGame = true.obs;

  Rx<bool> fiveCardsChoosen = false.obs;

  List<Challenge> challenges = [
    Challenge(
      id: '1',
      name: 'Startbonus',
      description: 'Spiele dein erstes VS-Spiel gegen einen Freund',
      duration: 1,
      rewardedCoins: 5,
    ),
    Challenge(
      id: '2',
      name: 'Den Sieg kann dir keiner nehmen',
      description: 'Gewinne dein erstes VS-Spiel gegen einen Freund',
      duration: 1,
      progress: 1,
      isCompleted: true,
      rewardedCoins: 5,
    ),
    Challenge(
      id: '3',
      name: 'Fünf auf einen Streich',
      description: 'Gewinne fünf VS-Spiele gegen einen Freund',
      duration: 5,
      rewardedCoins: 10,
      progress: 3,
    ),
    Challenge(
      id: '4',
      name: 'Sieben reichen nicht',
      description: 'Kaufe dir zum ersten Mal etwas im Shop',
      duration: 1,
      rewardedCoins: 5,
    ),
    Challenge(
      id: '5',
      name: 'Selbst ist der Spieler',
      description: 'Erstelle dein erstes VS-Spiel',
      duration: 1,
      rewardedCoins: 5,
    ),
    Challenge(
      id: '6',
      name: 'Lass das mal die anderen machen',
      description: 'Tritt einem VS-Spiel bei',
      duration: 1,
      rewardedCoins: 5,
    ),
  ];

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    debugPrint('onInit');
    debugPrint(FirebaseAuth.instance.currentUser!.uid);
    debugPrint('Is Loading: ${isLoading.value.toString()}');
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1482327748.
    user = await FirestoreDatabase.getUser(
      FirebaseAuth.instance.currentUser!.uid,
    );
    pages = [
      ClansView(
        controller: this,
      ),
      HomeView(
        controller: this,
      ),
      MyCardsView(),
      ShopView(
        controller: this,
      ),
    ];
    Future.delayed(
      Duration(
        seconds: 2,
      ),
    ).then((_) {
      isLoading.value = false;
    });

    debugPrint('Is Loading: ${isLoading.value.toString()}');
    super.onInit();
    change(null, status: RxStatus.success());
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

  void clickOnModeChanger() {
    debugPrint('clickOnModeChanger');
    createGame.value = !createGame.value;
    update();
  }

  void clickOnChallenge(int index) {
    debugPrint('clickOnChallenge $index');
    if (challenges[index].isCompleted) {
      debugPrint('Challenge completed');
      challenges[index].closed = true;
      update();
    }
  }

  void clickStartButton() {
    Get.to(
      () => CardSelectionView(
        controller: this,
      ),
    );
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
