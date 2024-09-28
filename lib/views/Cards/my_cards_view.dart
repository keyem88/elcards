import 'package:flutter/material.dart';

import '../../controller/main_menu_controller.dart';

class MyCardsView extends StatelessWidget {
  MyCardsView({
    super.key,
    required this.controller,
    this.asOverview = true,
  });

  final MainMenuController controller;
  final bool asOverview;

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'Build $runtimeType',
    );
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.user?.cardSet.cards.length,
      itemBuilder: (context, index) {
        return ListTile(
          tileColor: controller.user!.cardSet.cards[index].inCardSet
              ? Colors.green.shade100
              : null,
          onTap: () {
            if (asOverview) {
              controller.clickOnCard(context, index);
            } else {
              controller.selectCard(index);
            }
          },
          leading: CircleAvatar(
            backgroundColor:
                controller.user?.cardSet.cards[index].cardLevel.asColor,
            child: Icon(
              controller.user?.cardSet.cards[index].cardElement.asIcon,
            ),
          ),
          title: Text(
            controller.user?.cardSet.cards[index].name ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Attack: ',
                  ),
                  Text(
                    'Defense: ',
                  ),
                  Text(
                    'Speed: ',
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '${controller.user?.cardSet.cards[index].attack}',
                  ),
                  Text(
                    '${controller.user?.cardSet.cards[index].defense}',
                  ),
                  Text(
                    '${controller.user?.cardSet.cards[index].speed}',
                  ),
                ],
              ),
            ],
          )
          /* Text(
            'Attack: ${controller.user?.cardSet.cards[index].attack}\nDefense: ${controller.user?.cardSet.cards[index].defense}\nSpeed: ${controller.user?.cardSet.cards[index].speed}',
          ) */
          ,
          trailing: controller.user!.cardSet.cards[index].inCardSet
              ? const Icon(Icons.check)
              : null,
        );
      },
    );
  }
}
