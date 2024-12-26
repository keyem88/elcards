import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/themes/app_colors.dart';
import '../../controller/main_menu_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.controller,
  });

  final MainMenuController controller;

  @override
  Widget build(BuildContext context) {
    debugPrint('${Get.height}');
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              controller.clickOnModeChanger();
            },
            child: Container(
                height: Get.height / 12,
                width: Get.height / 9,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  border: Border(
                    right: BorderSide(
                      color: Colors.black,
                      width: 0.1,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primaryLight.withOpacity(0.2),
                        offset: Offset(0, 10),
                        blurRadius: 3,
                        spreadRadius: 0)
                  ],
                ),
                child: Obx(
                  () => controller.createGame.value
                      ? Column(
                          children: [
                            Text(
                              'Spiel erstellen',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '(Zum Ändern klicken)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Text(
                              'Spiel beitreten',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '(Zum Ändern klicken)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                )),
          ),
          GestureDetector(
            onTap: () {
              controller.clickStartButton();
            },
            child: Container(
              height: Get.height / 12,
              width: Get.height / 5.16,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
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
              child: Center(
                child: Obx(() => controller.createGame.value
                    ? Text(
                        'Erstellen'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        'Beitreten'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
