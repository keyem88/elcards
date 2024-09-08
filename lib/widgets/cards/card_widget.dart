import 'package:flutter/material.dart';
import 'package:myapp/config/themes/app_colors.dart';
import 'package:myapp/models/Card/playing_card.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.card,
      required this.width,
      required this.height});
  final double width;
  final double height;

  final PlayingCard card;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: AspectRatio(
        aspectRatio: 9 / 16,
        child: Card(
          shadowColor: card.cardLevel.asColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: card.cardLevel.asColor,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          color: AppColors.primary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //Name der Karte
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Text(
                    card.name,
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),

                //Foto + Element
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: height * 0.4,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: card.cardLevel.asColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(48),
                            child: Image.network(
                              'https://picsum.photos/400/300',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          backgroundColor: card.cardLevel.asColor,
                          child: Text(
                            '${card.valency}',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          backgroundColor: card.cardLevel.asColor,
                          child: Icon(
                            card.cardElement.asIcon,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //Beschreibung
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Text(
                    card.description,
                    textAlign: TextAlign.justify,
                  ),
                ),

                //Attribute
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Attack
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Attack',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            '${card.attack}',
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ),

                      //Verteidigung
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Defense',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            '${card.defense}',
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ),

                      //Geschwindigkeit
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Speed',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            '${card.speed}',
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
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
        ),
      ),
    );
  }
}
