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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(
                16.0,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(
                    0.3,
                  ),
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Herausforderungen'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: GetBuilder<MainMenuController>(
                        builder: (_) => ListView.builder(
                          itemCount: controller.challenges.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (controller.challenges[index].closed) {
                              return Container();
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  controller.clickOnChallenge(index);
                                },
                                child: ListTile(
                                  title: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(
                                        0.3,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          textAlign: TextAlign.center,
                                          controller.challenges[index].name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height / 31,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'lib/assets/icons/coin.png',
                                              ),
                                              Text(
                                                '${controller.challenges[index].rewardedCoins}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(
                                        0.4,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                          ),
                                          child: Text(
                                            controller
                                                .challenges[index].description,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                            bottom: 8.0,
                                          ),
                                          child: LinearProgressIndicator(
                                            semanticsLabel: 'Progress',
                                            semanticsValue: controller
                                                .challenges[index].progress
                                                .toString(),
                                            value: controller.challenges[index]
                                                    .progress /
                                                controller
                                                    .challenges[index].duration,
                                            backgroundColor:
                                                Colors.grey.withOpacity(
                                              0.3,
                                            ),
                                            minHeight: 10,
                                            valueColor: controller
                                                    .challenges[index]
                                                    .isCompleted
                                                ? AlwaysStoppedAnimation<Color>(
                                                    Colors.green)
                                                : AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
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
          ),
        ],
      ),
    );
  }
}
