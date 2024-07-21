import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/main_menu_controller.dart';
import 'package:myapp/views/Cards/my_cards_view.dart';

import '../main_menu_view.dart';

class InitialLoadingView extends StatelessWidget {
  InitialLoadingView({super.key});

  var controller = Get.put(
    MainMenuController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CircularProgressIndicator();
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.off(
                () => MainMenuView(),
              );
            });
          }
          return const CircularProgressIndicator();
        }),
      ),
    );
  }
}
