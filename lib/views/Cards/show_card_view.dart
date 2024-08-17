import 'package:flutter/widgets.dart';
import 'package:myapp/models/Card/playing_card.dart';
import 'package:myapp/widgets/cards/card_widget.dart';

class ShowCardView extends StatelessWidget {
  const ShowCardView({super.key, required this.card});

  final PlayingCard card;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CardWidget(
          card: card,
        ),
      ),
    );
  }
}
