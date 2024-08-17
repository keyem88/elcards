import 'package:flutter/material.dart';
import 'package:myapp/models/Card/playing_card.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.card});

  final PlayingCard card;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.amber,
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.network(
            'https://picsum.photos/${(MediaQuery.of(context).size.width * 0.9).toInt()}/${(MediaQuery.of(context).size.height * 0.3).toInt()}'),
      ),
    );
  }
}
