import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/themes/app_colors.dart';

import '../controller/main_menu_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.controller});

  final MainMenuController controller;

  @override
  Widget build(BuildContext context) {
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
                    child: Icon(
                      Icons.menu,
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
                  left: 16,
                ),
                child: SizedBox(
                  height: 100,
                  child: Image.asset(
                    'lib/assets/avatars/wizard.png',
                  ),
                ),
              ),
              //User Info
              Wrap(
                spacing: 5,
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
                          '200',
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
                        Text('700')
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
                          '2000',
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
  }

  @override
  Size get preferredSize => Size(
        Get.size.width,
        Get.size.height * 0.10,
      );
}
