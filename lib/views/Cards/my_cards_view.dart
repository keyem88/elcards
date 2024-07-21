import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/main_menu_controller.dart';

class MyCardsView extends StatelessWidget {
  MyCardsView({super.key});

  final controller = Get.put(
    MainMenuController(),
  );

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'Build $runtimeType',
    );
    return ListView.builder(
      itemCount: controller.user?.cardSet.cards.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor:
                controller.user?.cardSet.cards[index].cardLevel.asColor,
            child: Icon(
              controller.user?.cardSet.cards[index].cardElement.asIcon,
            ),
          ),
          title: Text(controller.user?.cardSet.cards[index].name ?? ""),
          subtitle: Text(
            'Attack: ${controller.user?.cardSet.cards[index].attack}\nDefense: ${controller.user?.cardSet.cards[index].defense}\nSpeed: ${controller.user?.cardSet.cards[index].speed}',
          ),
        );
      },
    );
  }
}
