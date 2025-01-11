import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/views/Trainer/trainer_fight_app_bar.dart';
import 'package:myapp/widgets/cards/card_widget.dart';

import '../../config/themes/app_colors.dart';
import '../../controller/trainer_controller.dart';

class TrainerFightView extends GetView<TrainerController> {
  const TrainerFightView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    debugPrint(hight.toString());
    return SafeArea(
      child: Scaffold(
        appBar: TrainerFightAppBar(),
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
                  child: GetBuilder<TrainerController>(
                    builder: (controller) => CardWidget(
                      card: controller.game.ownUser.cardDeck[index]!,
                      height: hight * 0.5,
                      showLifePoints: true,
                      greyWhenLifepointsZero: true,
                    ),
                  ),
                ),
                itemCount: 5,
                scrollDirection: Axis.horizontal,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                controller.cancelTraining();
              },
              child: const Text(
                'Training abbrechen',
              ),
            )
          ],
        ),
      ),
    );
  }
}
