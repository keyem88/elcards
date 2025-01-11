import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/themes/app_colors.dart';
import 'package:myapp/controller/main_menu_controller.dart';
import 'package:myapp/views/main_menu_view.dart';

import '../MyCards/my_cards_view.dart';

class CardSelectionView extends StatelessWidget {
  CardSelectionView({
    this.trainerMode = false,
    super.key,
  });

  final MainMenuController controller = Get.find();
  final bool trainerMode;

  @override
  Widget build(BuildContext context) {
    controller.fiveCardsChoosen.value = false;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GetBuilder(
                builder: (MainMenuController controller) => MyCardsView(
                  asOverview: false,
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
            Row(
              mainAxisAlignment: trainerMode
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceEvenly,
              children: [
                trainerMode
                    ? SizedBox()
                    : ElevatedButton(
                        onPressed: () {
                          Get.off(
                            () => MainMenuView(),
                          );
                        },
                        child: Text(
                          'Cancel',
                        ),
                      ),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.fiveCardsChoosen.value
                        ? () {
                            trainerMode
                                ? controller.startTrainerMode()
                                : controller.createGame.value
                                    ? controller.clickStartOwnGameButton()
                                    : controller.clickJoinGameButton();
                          }
                        : null,
                    child: trainerMode
                        ? controller.fiveCardsChoosen.value
                            ? Text(
                                'Start Training',
                              )
                            : Text(
                                'Choose 5 cards',
                              )
                        : controller.createGame.value
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
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
