import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:myapp/config/themes/app_colors.dart';
import 'package:myapp/widgets/custom_app_bar.dart';

import '../controller/main_menu_controller.dart';

class MainMenuView extends StatelessWidget {
  MainMenuView({
    super.key,
  });

  final MainMenuController controller = Get.put(MainMenuController());

  Duration duration = Duration(
    milliseconds: 500,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: CustomAppBar(),
      /* appBar:  AppBar(
          backgroundColor: AppColors.primary,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(AppConstants.appName),
              Obx(() {
                if (controller.isLoading.value) {
                  return Text(
                    'Loading User',
                    style: TextStyle(fontSize: 11),
                  );
                } else {
                  return Text(
                    controller.user!.email,
                    style: TextStyle(fontSize: 11),
                  );
                }
              })
            ],
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: () {
                      FirebaseAuthentication.signOut().then((_) {
                        Get.deleteAll();
                        Get.to(() => const SignUpView());
                      });
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                  ),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: () {
                Get.to(
                  () => SettingsView(),
                );
              },
              icon: const Icon(Icons.settings),
              label: const Text('Settings'),
            ),
          ],
        ), */
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return controller.pages[controller.selectedIndex.value];
      }),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        elevation: 30,
        color: AppColors.primary,
        padding: EdgeInsets.all(0),
        shape: CircularNotchedRectangle(),
        child: Stack(alignment: AlignmentDirectional.topEnd, children: [
          Column(
            children: [
              Container(
                color: Colors.transparent,
                height: 10,
              ),
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      20,
                    ),
                    topRight: Radius.circular(
                      20,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Clans-Button
              BottomMenuButton(
                title: 'Clans',
                duration: duration,
                iconPath: 'lib/assets/icons/clans.png',
                index: 0,
                totalButtons: 5,
              ),
              //Trainer-Button
              BottomMenuButton(
                title: 'Trainer',
                duration: duration,
                iconPath: 'lib/assets/icons/trainer.png',
                index: 1,
                totalButtons: 5,
              ),
              //HomeButton
              BottomMenuButton(
                title: 'Home',
                duration: duration,
                iconPath: 'lib/assets/icons/homeIcon.png',
                index: 2,
                totalButtons: 5,
              ),
              //MyCardsButton
              BottomMenuButton(
                title: 'My Cards',
                duration: duration,
                iconPath: 'lib/assets/icons/myCardsIcon.png',
                index: 3,
                totalButtons: 5,
              ),
              //ShopButton
              BottomMenuButton(
                title: 'Shop',
                duration: duration,
                iconPath: 'lib/assets/icons/shop.png',
                index: 4,
                totalButtons: 5,
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class BottomMenuButton extends StatelessWidget {
  BottomMenuButton({
    super.key,
    required this.duration,
    required this.index,
    required this.title,
    required this.iconPath,
    required this.totalButtons,
  });

  final MainMenuController controller = Get.find();
  final Duration duration;
  final int index;
  final String title;
  final String iconPath;
  final int totalButtons;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        alignment: AlignmentDirectional.center,
        children: [
          AnimatedContainer(
            decoration: BoxDecoration(
              color: controller.selectedIndex.value == index
                  ? Colors.yellow
                  : AppColors.primaryLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  20,
                ),
                topRight: Radius.circular(
                  20,
                ),
              ),
              boxShadow: controller.selectedIndex.value == index
                  ? [
                      BoxShadow(
                          color: Colors.yellow.withOpacity(0.2),
                          offset: Offset(0, -10),
                          blurRadius: 3,
                          spreadRadius: 0)
                    ]
                  : [],
            ),
            width: Get.width / totalButtons,
            height: controller.selectedIndex.value == index ? 80 : 60,
            duration: duration,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                padding: EdgeInsets.all(
                  0,
                ),
                onPressed: () {
                  controller.onItemTapped(index);
                },
                icon: Image.asset(
                  iconPath,
                  width: controller.selectedIndex.value == index ? 45 : 35,
                ),
              ),
              Visibility(
                visible: controller.selectedIndex.value == index,
                child: Text(
                  title.toUpperCase(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
