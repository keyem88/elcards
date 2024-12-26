import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/themes/app_colors.dart';
import 'package:myapp/controller/main_menu_controller.dart';

import '../MyCards/my_cards_view.dart';

class CardSelectionView extends StatelessWidget {
  const CardSelectionView({super.key, required this.controller});

  final MainMenuController controller;

  @override
  Widget build(BuildContext context) {
    controller.fiveCardsChoosen.value = false;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          Expanded(
            child: GetBuilder(
              builder: (MainMenuController controller) => MyCardsView(
                asOverview: false,
                controller: controller,
              ),
            ),
          ),
          /* Expanded(
            flex: 1,
            child: GetBuilder(
              builder: (MainMenuController controller) => GridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: controller.user!.cardDeck.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemBuilder: (context, index) {
                    if (controller.user!.cardDeck[index] == null) {
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.removeCardFromCardDeck(index);
                          },
                          child: SmallSelectionCard(
                              card: controller.user!.cardDeck[index]!),
                        ),
                      );
                    }
                  }),
            ),
          ), */
          Obx(() => ElevatedButton(
                onPressed: controller.fiveCardsChoosen.value
                    ? () {
                        controller.createGame.value
                            ? controller.clickStartOwnGameButton()
                            : controller.clickJoinGameButton();
                      }
                    : null,
                child: controller.createGame.value
                    ? controller.fiveCardsChoosen.value
                        ? Text(
                            'Create Game!',
                          )
                        : Text(
                            'Select 5 Cards!',
                          )
                    : controller.fiveCardsChoosen.value
                        ? Text(
                            'Join Game!',
                          )
                        : Text(
                            'Select 5 Cards!',
                          ),
              ))
        ],
      ),
    );
  }
}
