import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/game_controller.dart';
import 'package:myapp/database/firebase/firestore_database.dart';
import 'package:myapp/models/User/user.dart';
import 'package:myapp/views/Cards/my_cards_view.dart';
import 'package:myapp/views/Game/game_main_view.dart';
import 'package:myapp/views/Game/join_game_view.dart';
import 'package:myapp/views/Game/start_new_game_view.dart';

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

  void clickJoinGameButton() {
    debugPrint('clickJoinGameButton');
    Get.to(
      () => JoinGameView(
        controller: GameController(
          user: user!,
        ),
      ),
    );
  }

  void clickStartOwnGameButton() {
    debugPrint('clickStartOwnGameButton');
    Get.to(
      () => StartNewGameView(
        controller: GameController(
          user: user!,
        ),
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
