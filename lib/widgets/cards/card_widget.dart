import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:myapp/config/themes/app_colors.dart';
import 'package:myapp/controller/game_controller.dart';
import 'package:myapp/models/Card/playing_card.dart';
import 'package:myapp/widgets/attribute_circle.dart';

class CardWidget extends StatelessWidget {
  CardWidget({
    super.key,
    this.height,
    this.size = 130,
    required this.card,
    this.controller,
    this.showLifePoints = false,
    this.greyWhenLifepointsZero = false,
    this.attackVisible = true,
    this.defenseVisible = true,
    this.speedVisible = true,
    this.levelColor,
    this.lowerAttribute = false,
  });

  final double? height;

  final double size;

  final PlayingCard card;

  final GameController? controller;

  final bool showLifePoints;

  final bool greyWhenLifepointsZero;

  final bool attackVisible;

  final bool defenseVisible;

  final bool speedVisible;

  final bool lowerAttribute;

  Color? levelColor;

  void changeLevelColor(Color color) {
    levelColor = color;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: height == null ? null : height! * 0.8,
      child: Obx(
        () => Card(
          shadowColor: card.cardLevel.asColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: card.selectedForTurn.value
                  ? Colors.red
                  : greyWhenLifepointsZero
                      ? card.livePoints > 0
                          ? card.cardLevel.asColor
                          : Colors.grey.shade700
                      : card.cardLevel.asColor,
              width: card.selectedForTurn.value ? 6 : 3,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          color: greyWhenLifepointsZero
              ? card.livePoints > 0
                  ? AppColors.primaryLight
                  : Colors.grey
              : AppColors.primaryLight,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    //Name der Karte + AttributeCircle
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: [
                            AttributeCircle(
                              size: size,
                              card: card,
                              lowerAttribute: lowerAttribute,
                              attackVisible: attackVisible,
                              defenseVisible: defenseVisible,
                              speedVisible: speedVisible,
                              segmentColors: greyWhenLifepointsZero
                                  ? card.livePoints > 0
                                      ? [
                                          Colors.red.shade400,
                                          Colors.blue.shade400,
                                          Colors.green.shade400,
                                        ]
                                      : [
                                          Colors.grey.shade300,
                                          Colors.grey.shade400,
                                          Colors.grey.shade700,
                                        ]
                                  : [
                                      Colors.red.shade400,
                                      Colors.blue.shade400,
                                      Colors.green.shade400,
                                    ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: AutoSizeText(
                                  card.name,
                                  style: const TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ],
                        )),
                    //Beschreibung
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: AutoSizeText(
                        card.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 24),
                        maxLines: 2,
                      ),
                    ),

                    //Foto + Element
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: greyWhenLifepointsZero
                                    ? card.livePoints > 0
                                        ? card.cardLevel.asColor
                                        : Colors.grey.shade700
                                    : card.cardLevel.asColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(48),
                                  child: greyWhenLifepointsZero
                                      ? card.livePoints > 0
                                          ? Image.network(
                                              'https://picsum.photos/1000/1000',
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              foregroundDecoration:
                                                  const BoxDecoration(
                                                color: Colors.grey,
                                                backgroundBlendMode:
                                                    BlendMode.saturation,
                                              ),
                                              child: Image.network(
                                                'https://picsum.photos/1000/1000',
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                      : Image.network(
                                          'https://picsum.photos/1000/1000',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),

                            //Element
                            Align(
                              alignment: Alignment.topLeft,
                              child: CircleAvatar(
                                backgroundColor: levelColor ??
                                    (greyWhenLifepointsZero
                                        ? card.livePoints > 0
                                            ? card.cardLevel.asColor
                                            : Colors.grey.shade700
                                        : card.cardLevel.asColor),
                                maxRadius: 30,
                                child: Icon(
                                  card.cardElement.asIcon,
                                  size: 50,
                                ),
                              ),
                            ),

                            //Summe Punkte
                            Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                backgroundColor: greyWhenLifepointsZero
                                    ? card.livePoints > 0
                                        ? card.cardLevel.asColor
                                        : Colors.grey.shade700
                                    : card.cardLevel.asColor,
                                maxRadius: 30,
                                child: Text(
                                  "${card.valency}",
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Stark/Schwach
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Text('Stark gegen: '),
                            Icon(card.cardElement.lowerElement().asIcon)
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Schwach gegen: '),
                            Icon(card.cardElement.higherElement().asIcon)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),

              //Lebenspunkte
              showLifePoints
                  ? Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        backgroundColor: greyWhenLifepointsZero
                            ? card.livePoints > 0
                                ? card.cardLevel.asColor
                                : Colors.grey.shade700
                            : card.cardLevel.asColor,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Icon(Icons.flash_on, size: 14),
                              ),
                              TextSpan(
                                  text: "${card.livePoints}",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
