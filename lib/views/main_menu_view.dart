import 'package:flutter/material.dart';
import 'package:myapp/models/playing_card.dart';

class MainMenuView extends StatelessWidget {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    List<PlayingCard> cards = [];
    for (int i = 0; i < 10; i++) {
      cards.add(PlayingCard.random());
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Main Menu'),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(cards[index].cardElement.asIcon),
                title: Text(cards[index].name),
                subtitle: Text(
                  'Attack: ${cards[index].attack}\nDefense: ${cards[index].defense}\nSpeed: ${cards[index].speed}',
                ),
                tileColor: cards[index].cardLevel.asColor,
              );
            },
          ),
        ));
  }
}
