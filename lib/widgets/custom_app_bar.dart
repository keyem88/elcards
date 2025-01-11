import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/themes/app_colors.dart';

import '../controller/main_menu_controller.dart';
import '../database/firebase/auth.dart';
import '../views/Other/sign_up_view.dart';

class CustomAppBar extends GetView<MainMenuController>
    implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              //Background
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: preferredSize.height * 0.8,
                        width: preferredSize.width * 0.85,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
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
                        height: preferredSize.height * 0.8,
                        width: preferredSize.width * 0.15,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.black,
                              width: 0.1,
                            ),
                          ),
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(
                              20,
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
                        child: PopupMenuButton(
                          icon: Icon(Icons.menu),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              onTap: () {
                                FirebaseAuthentication.signOut().then((_) {
                                  Get.deleteAll();
                                  Get.to(() => const SignUpView());
                                });
                              },
                              child: Text(
                                'Logout',
                              ),
                            ),
                            PopupMenuItem(
                              child: Text(
                                'Settings',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                    ),
                    child: SizedBox(
                      width: Get.height / 11,
                      child: Image.asset(
                        'lib/assets/avatars/${controller.user!.avatar}.png',
                      ),
                    ),
                  ),
                  //User Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        height: 30,
                        width: 85,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('lib/assets/icons/star.png'),
                            Text(
                              '${controller.user!.exp}',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        height: 30,
                        width: 65,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('lib/assets/icons/cards.png'),
                            Text(
                              '${controller.user!.cardSet.cards.length}',
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        height: 30,
                        width: 85,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'lib/assets/icons/coin.png',
                              scale: 0.5,
                            ),
                            Text(
                              '${controller.user!.coins}',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
      onLoading: CircularProgressIndicator(),
    );
  }

  @override
  Size get preferredSize => Size(
        Get.size.width,
        Get.size.height * 0.10,
      );
}
