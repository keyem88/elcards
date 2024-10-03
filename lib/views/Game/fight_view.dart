import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/game_controller.dart';
import 'package:myapp/views/main_menu_view.dart';
import 'package:myapp/widgets/cards/card_widget.dart';

class FightView extends StatelessWidget {
  const FightView({
    super.key,
    required this.controller,
  });

  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('1 vs 1 Fight'),
        actions: [
          IconButton(
            onPressed: () {
              controller.sendData({
                'connected': controller.userName,
                'cards': jsonEncode(controller.user.cardDeck),
              }, controller.connectedDevice!.deviceId);
            },
            icon: const Icon(
              Icons.abc,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              (controller.game.ownTurn
                  ? 'Du bist an der Reihe. Wähle deine Karte und deinen Zug!'
                  : 'Der Gegner ist an der Reihe. Welche Karte möchtest du einsetzen?'),
              style: const TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  controller.clickCardInTurn(index);
                },
                child: CardWidget(
                    card: controller.user.cardDeck[index]!,
                    width: 100,
                    height: 500),
              ),
              itemCount: 5,
              scrollDirection: Axis.horizontal,
            ),
          ),
          /* GridView.builder(
              addRepaintBoundaries: false,
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
              }), */
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
