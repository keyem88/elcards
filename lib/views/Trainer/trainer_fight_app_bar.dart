import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/themes/app_colors.dart';
import 'package:myapp/controller/trainer_controller.dart';

class TrainerFightAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  TrainerFightAppBar({
    super.key,
  });

  final TrainerController controller = Get.put(TrainerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          //Background
          Column(
            children: [
              Container(
                height: preferredSize.height * 0.8,
                width: preferredSize.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primaryLight.withOpacity(0.2),
                        offset: Offset(0, 10),
                        blurRadius: 3,
                        spreadRadius: 0)
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                height: preferredSize.height * 0.2,
              ),
            ],
          ),
          //Foreground
          //Avatar
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 8,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: Get.height / 11,
                    child: Transform.scale(
                      scaleX: -1,
                      child: GestureDetector(
                        onTap: () {
                          controller.testFunction();
                        },
                        child: Image.asset(
                          'lib/assets/avatars/${controller.game.ownUser.avatar}.png',
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Text(
                      '${controller.game.ownPoints.value}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              width: Get.width * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 5,
                      crossAxisCount: 5, // number of items in each row
                    ),

                    itemCount: 5, // total number of items
                    itemBuilder: (context, index) {
                      return Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            color: controller.game.turn.value == index
                                ? Colors.yellow
                                : AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Obx(
                    () => Text(
                      controller.game.ownTurn.value
                          ? 'Dein Zug'
                          : 'Trainer Zug',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                left: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => Text(
                      '${controller.game.trainerPoints.value}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.height / 11,
                    child: Image.asset(
                      'lib/assets/avatars/trainer.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(
        Get.size.width,
        Get.size.height * 0.10,
      );
}
