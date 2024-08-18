import 'package:flutter/material.dart';
import 'package:myapp/models/Card/playing_card.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.card});

  final PlayingCard card;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: card.cardLevel.asColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //Name der Karte
            Text(
              card.name,
              style: const TextStyle(fontSize: 24),
            ),

            //Foto + Element
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      child: Image.network(
                          'https://picsum.photos/${(MediaQuery.of(context).size.width * 0.9).toInt()}/${(MediaQuery.of(context).size.height * 0.5).toInt()}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: card.cardLevel.asColor,
                        child: Icon(
                          card.cardElement.asIcon,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: card.cardLevel.asColor,
                          child: Text(
                            '${card.valency}',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Beschreibung
            Text(
              card.description,
              textAlign: TextAlign.justify,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Stark gegen: '),
                    Icon(card.cardElement.lowerElement().asIcon)
                  ],
                ),
                Row(
                  children: [
                    Text('Schwach gegen: '),
                    Icon(card.cardElement.higherElement().asIcon)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
