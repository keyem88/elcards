import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/themes/app_colors.dart';
import 'package:myapp/utils/constants/app_constants.dart';
import 'package:myapp/views/Other/sign_up_view.dart';
import 'package:myapp/views/Settings/settings_view.dart';
import 'package:myapp/widgets/custom_app_bar.dart';

import '../controller/main_menu_controller.dart';
import '../database/firebase/auth.dart';

class MainMenuView extends StatelessWidget {
  MainMenuView({super.key});

  final controller = Get.put(
    MainMenuController(),
  );

  Duration duration = Duration(
    milliseconds: 500,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: CustomAppBar(controller: controller),
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
        bottomNavigationBar: Obx(
          () => BottomAppBar(
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
                  Stack(alignment: AlignmentDirectional.center, children: [
                    AnimatedContainer(
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == 0
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
                        boxShadow: controller.selectedIndex.value == 0
                            ? [
                                BoxShadow(
                                    color: Colors.yellow.withOpacity(0.2),
                                    offset: Offset(0, -10),
                                    blurRadius: 3,
                                    spreadRadius: 0)
                              ]
                            : [],
                      ),
                      width: Get.width / 4,
                      height: controller.selectedIndex.value == 0 ? 80 : 60,
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
                            controller.onItemTapped(0);
                          },
                          icon: Image.asset(
                            'lib/assets/icons/clans.png',
                            width:
                                controller.selectedIndex.value == 0 ? 45 : 35,
                          ),
                        ),
                        Visibility(
                          visible: controller.selectedIndex.value == 0,
                          child: Text(
                            'Clans'.toUpperCase(),
                          ),
                        )
                      ],
                    ),
                  ]),
                  Stack(alignment: AlignmentDirectional.center, children: [
                    AnimatedContainer(
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == 1
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
                        boxShadow: controller.selectedIndex.value == 1
                            ? [
                                BoxShadow(
                                    color: Colors.yellow.withOpacity(0.2),
                                    offset: Offset(0, -10),
                                    blurRadius: 3,
                                    spreadRadius: 0)
                              ]
                            : [],
                      ),
                      width: Get.width / 4,
                      height: controller.selectedIndex.value == 1 ? 80 : 60,
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
                            controller.onItemTapped(1);
                          },
                          icon: Image.asset(
                            'lib/assets/icons/homeIcon.png',
                            width:
                                controller.selectedIndex.value == 1 ? 45 : 35,
                          ),
                        ),
                        Visibility(
                          visible: controller.selectedIndex.value == 1,
                          child: Text(
                            'Home'.toUpperCase(),
                          ),
                        )
                      ],
                    ),
                  ]),
                  Stack(alignment: AlignmentDirectional.center, children: [
                    AnimatedContainer(
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == 2
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
                        boxShadow: controller.selectedIndex.value == 2
                            ? [
                                BoxShadow(
                                    color: Colors.yellow.withOpacity(0.2),
                                    offset: Offset(0, -10),
                                    blurRadius: 3,
                                    spreadRadius: 0)
                              ]
                            : [],
                      ),
                      width: Get.width / 4,
                      height: controller.selectedIndex.value == 2 ? 80 : 60,
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
                            controller.onItemTapped(2);
                          },
                          icon: Image.asset(
                            'lib/assets/icons/myCardsIcon.png',
                            width:
                                controller.selectedIndex.value == 2 ? 45 : 35,
                          ),
                        ),
                        Visibility(
                          visible: controller.selectedIndex.value == 2,
                          child: Text(
                            'My Cards'.toUpperCase(),
                          ),
                        )
                      ],
                    ),
                  ]),
                  Stack(alignment: AlignmentDirectional.center, children: [
                    AnimatedContainer(
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == 3
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
                        boxShadow: controller.selectedIndex.value == 3
                            ? [
                                BoxShadow(
                                    color: Colors.yellow.withOpacity(0.2),
                                    offset: Offset(0, -10),
                                    blurRadius: 3,
                                    spreadRadius: 0)
                              ]
                            : [],
                      ),
                      width: Get.width / 4,
                      height: controller.selectedIndex.value == 3 ? 80 : 60,
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
                            controller.onItemTapped(3);
                          },
                          icon: Image.asset(
                            'lib/assets/icons/shop.png',
                            width:
                                controller.selectedIndex.value == 3 ? 45 : 35,
                          ),
                        ),
                        Visibility(
                          visible: controller.selectedIndex.value == 3,
                          child: Text(
                            'Shop'.toUpperCase(),
                          ),
                        )
                      ],
                    ),
                  ]),
                ],
              )
            ]),
          ),
        )

        /* Obx(
          () => BottomNavigationBar(
            unselectedFontSize: 0.0,
            selectedFontSize: 0.0,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            elevation: 0,
            backgroundColor: AppColors.primary,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'lib/assets/icons/vsIcon.png',
                  width: 45,
                ),
                activeIcon: Image.asset(
                  'lib/assets/icons/vsIcon.png',
                  width: 65,
                ),
                label: 'Game',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'lib/assets/icons/homeIcon.png',
                  width: 45,
                ),
                activeIcon: Image.asset(
                  'lib/assets/icons/homeIcon.png',
                  width: 65,
                ),
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
        ) */
        );
  }
}
