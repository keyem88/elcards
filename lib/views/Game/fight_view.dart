import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/game_controller.dart';
import 'package:myapp/views/main_menu_view.dart';
import 'package:myapp/widgets/cards/small_selection_card.dart';

class FightView extends StatelessWidget {
  const FightView({
    super.key,
    required this.controller,
  });

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
          Center(
            child: Text(
              'Own Device id: ${controller.userName}',
            ),
          ),
          GridView.builder(
              itemCount: 5,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: SmallSelectionCard(
                      card: controller.user.cardDeck[index]!),
                );
              }),
          GridView.builder(
              itemCount: 5,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: SmallSelectionCard(
                      card: controller.oponent!.cardDeck[index]!),
                );
              }),
          ElevatedButton(
            onPressed: () {
              controller.sendData({
                'connected': controller.userName,
                'cards': jsonEncode(controller.user.cardDeck),
              }, controller.connectedDevice!.deviceId);
            },
            child: const Text(
              'send',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.sendData({
                'message': 'Hello i am ${controller.userName}',
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
