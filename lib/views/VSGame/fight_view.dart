import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/game_controller.dart';
import 'package:myapp/views/main_menu_view.dart';
import 'package:myapp/widgets/cards/card_widget.dart';
import 'package:myapp/widgets/fight_app_bar.dart';

import '../../config/themes/app_colors.dart';

class FightView extends StatelessWidget {
  const FightView({
    super.key,
    required this.controller,
  });

  final GameController controller;

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    debugPrint(hight.toString());
    return SafeArea(
      child: Scaffold(
        appBar: FightAppBar(),
        backgroundColor: AppColors.primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    controller.clickCardInTurn(index, context);
                  },
                  child: CardWidget(
                    card: controller.user.cardDeck[index]!,
                    height: hight * 0.5,
                    showLifePoints: true,
                  ),
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
                controller
                    .disconnectDevice(controller.connectedDevice!.deviceId);
                Get.offAll(() => MainMenuView());
              },
              child: const Text(
                'Disconnect',
              ),
            )
          ],
        ),
      ),
    );
  }
}
