import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/main_menu_controller.dart';

class GameMainMenu extends StatelessWidget {
  GameMainMenu({super.key});

  final MainMenuController controller = Get.put(
    MainMenuController(),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: controller.clickStartOwnGameButton,
            child: const Text(
              "Start own game",
            ),
          ),
          ElevatedButton(
            onPressed: controller.clickJoinGameButton,
            child: const Text(
              "Join game",
            ),
          )
        ],
      ),
    );
  }
}
