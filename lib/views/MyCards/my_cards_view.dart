import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/themes/app_colors.dart';

import '../../controller/main_menu_controller.dart';

class MyCardsView extends StatelessWidget {
  MyCardsView({
    super.key,
    this.asOverview = true,
  });

  final MainMenuController controller = Get.find();
  final bool asOverview;

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'Build $runtimeType',
    );
    return Padding(
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: AppColors.primaryLight,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.user!.cardSet.cards.length,
            itemBuilder: (context, index) {
              return ListTile(
                  tileColor: controller.user!.cardSet.cards[index].inCardSet
                      ? AppColors.secondary
                      : AppColors.primaryLight,
                  onTap: () {
                    if (asOverview) {
                      controller.clickOnCard(context, index);
                    } else {
                      controller.selectCard(index);
                    }
                  },
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: controller
                            .user?.cardSet.cards[index].cardLevel.asColor,
                        child: Icon(
                          controller
                              .user?.cardSet.cards[index].cardElement.asIcon,
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    textAlign: TextAlign.center,
                    controller.user?.cardSet.cards[index].name.toUpperCase() ??
                        "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${controller.user!.cardSet.cards[index].cardElement.asString.toUpperCase()} (${controller.user!.cardSet.cards[index].cardNumber})',
                          ),
                          Text(
                            '${controller.user!.cardSet.cards[index].valency}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            controller
                                .user!.cardSet.cards[index].cardLevel.asText
                                .toUpperCase(),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  )
                  /* Text(
                  'Attack: ${controller.user?.cardSet.cards[index].attack}\nDefense: ${controller.user?.cardSet.cards[index].defense}\nSpeed: ${controller.user?.cardSet.cards[index].speed}',
                ) */
                  ,
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'A: ${controller.user?.cardSet.cards[index].attack}'),
                      Text(
                          'D: ${controller.user?.cardSet.cards[index].defense}'),
                      Text('S: ${controller.user?.cardSet.cards[index].speed}'),
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
