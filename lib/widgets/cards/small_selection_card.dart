import 'package:flutter/material.dart';
import 'package:myapp/models/Card/playing_card.dart';

import 'attribute_text.dart';

class SmallSelectionCard extends StatelessWidget {
  const SmallSelectionCard({super.key, required this.card});

  final PlayingCard card;
  final TextScaler textScaler = const TextScaler.linear(0.5);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: textScaler,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: card.cardLevel.asColor,
          border: Border.all(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  applyTextScaling: true,
                  card.cardElement.asIcon,
                ),
                AttribtueText(
                  icon: Icons.bolt,
                  text: '${card.valency}',
                ),
              ],
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              card.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            AttribtueText(
              icon: Icons.arrow_forward,
              text: '${card.attack}',
            ),
            AttribtueText(
              icon: Icons.arrow_back,
              text: '${card.defense}',
            ),
            AttribtueText(
              icon: Icons.speed,
              text: '${card.speed}',
            ),
          ],
        ),
      ),
    );
  }
}
