import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/main_menu_controller.dart';
import 'package:myapp/widgets/cards/small_selection_card.dart';

import '../Cards/my_cards_view.dart';

class CardSelectionView extends StatelessWidget {
  const CardSelectionView({super.key, required this.controller});

  final MainMenuController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: const Text(
              'Please select your Card-Deck',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
          ),
          Expanded(
            flex: 5,
            child: GetBuilder(
              builder: (MainMenuController controller) => MyCardsView(
                asOverview: false,
                controller: controller,
              ),
            ),
          ),
          Expanded(
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
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: controller.fiveCardsChoosen.value
                          ? () {
                              controller.clickStartOwnGameButton();
                            }
                          : null,
                      child: const Text(
                        'Create Game!',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: controller.fiveCardsChoosen.value
                          ? () {
                              controller.clickJoinGameButton();
                            }
                          : null,
                      child: const Text(
                        'Join Game!',
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
