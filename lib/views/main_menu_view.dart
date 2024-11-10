import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/themes/app_colors.dart';
import 'package:myapp/utils/constants/app_constants.dart';
import 'package:myapp/views/Other/sign_up_view.dart';
import 'package:myapp/views/Settings/settings_view.dart';

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
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return controller.pages[controller.selectedIndex.value];
        }),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            unselectedFontSize: 0.0,
            selectedFontSize: 0.0,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            elevation: 0,
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
            selectedIconTheme: IconThemeData(
              color: AppColors.primary,
              size: 40,
            ),
            onTap: controller.onItemTapped,
          ),
        ));
  }
}
