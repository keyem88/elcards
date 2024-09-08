import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/main_menu_controller.dart';

import '../Cards/my_cards_view.dart';

class CardSelectionView extends StatelessWidget {
  const CardSelectionView({super.key, required this.controller});

  final MainMenuController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Please select your Card-Deck',
            style: TextStyle(fontSize: 24),
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
                    padding: EdgeInsets.all(8),
                    itemCount: controller.user!.cardDeck.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    ),
                    itemBuilder: (context, index) {
                      if (controller.user!.cardDeck[index] == null) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            controller.removeCardFromCardDeck(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller
                                  .user!.cardDeck[index]!.cardLevel.asColor,
                              border: Border.all(),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '${controller.user!.cardDeck[index]?.attack}',
                                ),
                                Text(
                                  '${controller.user!.cardDeck[index]?.defense}',
                                ),
                                Text(
                                  '${controller.user!.cardDeck[index]?.speed}',
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    }),
              ))
        ],
      ),
    );
  }
}
