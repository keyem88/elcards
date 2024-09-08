import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/game_controller.dart';
import 'package:myapp/views/main_menu_view.dart';

class FightView extends StatelessWidget {
  const FightView({super.key, required this.controller});

  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
                'Connected Device: ${controller.connectedDevice!.deviceName}'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.sendData({
                'connected': controller.userName,
              }, controller.connectedDevice!.deviceId);
            },
            child: const Text(
              'send',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.disconnectDevice(controller.connectedDevice!.deviceId);
              Get.offAll(MainMenuView());
            },
            child: const Text(
              'Disconnect',
            ),
          )
        ],
      ),
    );
  }
}
