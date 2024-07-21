import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/themes/app_colors.dart';
import 'package:myapp/utils/constants/app_constants.dart';

import '../controller/main_menu_controller.dart';
import '../database/firebase/auth.dart';

class MainMenuView extends StatelessWidget {
  MainMenuView({super.key});

  final controller = Get.put(
    MainMenuController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(AppConstants.appName),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuthentication.signOut();
                Get.offAllNamed(AppConstants.loginRoute);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Obx(() {
          return controller.pages[controller.selectedIndex.value];
        }),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: AppColors.foreground,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.gamepad_outlined),
                label: 'Game',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'My Cards',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shop_2_outlined),
                label: 'Shop',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: AppColors.primary,
            selectedIconTheme: IconThemeData(
              color: AppColors.primary,
              size: 40,
            ),
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: controller.onItemTapped,
          ),
        ));
  }
}
