import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/game_controller.dart';
import 'package:myapp/database/firebase/firestore_database.dart';

import 'package:myapp/models/User/user.dart';
import 'package:myapp/utils/constants/app_constants.dart';
import 'package:myapp/views/Cards/my_cards_view.dart';

import 'package:myapp/views/Game/game_main_view.dart';
import 'package:myapp/views/Game/join_game_view.dart';
import 'package:myapp/views/Game/start_new_game_view.dart';
import 'package:myapp/utils/permissions/permission_checker.dart';

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
      GameMainMenu(),
      MyCardsView(),
      MyCardsView(),
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
    showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: CardWidget(card: user!.cardSet.cards[index]),
          );
          /*showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => );*/
        });
  }

  void clickJoinGameButton() async {
    debugPrint('clickJoinGameButton');
    if (await PermissionChecker.checkAllPermissions()) {
      Get.to(
        () => JoinGameView(
          controller: GameController(
            deviceType: DeviceType.advicer,
            user: user!,
          ),
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
    GameController gameController = GameController(
      deviceType: DeviceType.browser,
      user: user!,
    );
    String? error = await gameController.createGame();
    if (error != null) {
      Get.snackbar('Error', error);
      return;
    } else {
      Get.to(
        () => StartNewGameView(
          controller: gameController,
        ),
      );
    }
  }

  @override
  void dispose() {
    debugPrint('dispose');
    user = null;
    isLoading.value = true;
    super.dispose();
  }
}
