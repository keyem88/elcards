import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/models/Card/playing_card.dart';
import 'package:myapp/models/Game/vs_game.dart';
import 'package:myapp/utils/constants/app_constants.dart';

class TurnResultDialog extends StatefulWidget {
  const TurnResultDialog({
    super.key,
    required this.result,
    required this.ownCard,
    required this.oponentCard,
    required this.actionType,
    required this.ownTurn,
    required this.game,
    required this.ownValue,
    required this.oponentValue,
  });

  final TurnResult result;
  final PlayingCard ownCard;
  final PlayingCard oponentCard;
  final ActionType actionType;
  final bool ownTurn;
  final VSGame game;
  final int ownValue;
  final int oponentValue;

  @override
  State<TurnResultDialog> createState() => _TurnResultDialogState();
}

class _TurnResultDialogState extends State<TurnResultDialog> {
  int currentIndex = 1;
  Timer? _timer;
  List<bool> visibility = [true, false, false, false];

  @override
  void initState() {
    super.initState();
    _startTextChange();
  }

  Future<void> _startTextChange() async {
    _timer = Timer.periodic(
        const Duration(
          seconds: 2,
        ), (timer) async {
      if (currentIndex <= 3) {
        setState(() {
          visibility[currentIndex] = true;
          currentIndex++;
        });
      } else {
        Future.delayed(
          Duration(
            seconds: 2,
          ),
        ).then((_) {
          _timer?.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Text getTitle() {
    if (widget.result == TurnResult.beats) {
      return const Text(
        'Runde gewonnen!',
        style: TextStyle(
          color: Colors.green,
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 2,
      );
    } else {
      if (widget.result == TurnResult.beaten) {
        return const Text(
          'Runde verloren!',
          style: TextStyle(
            color: Colors.red,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        );
      } else {
        return const Text(
          'Unentschieden!',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        );
      }
    }
  }

  Column getContentOwnTurn() {
    String ownAttackSentence = '';
    String elementAdvantage = 'Kein Element schlägt das andere';
    String points = '';
    switch (widget.actionType) {
      case ActionType.attack:
        ownAttackSentence = 'Du greifst mit ${widget.ownCard.name} an';
        switch (widget.result) {
          case TurnResult.beats:
            points = 'Dein Angriff ist stärker';
          case TurnResult.beaten:
            points = 'Dein Angriff reicht nicht aus';
          case TurnResult.draw:
            points = 'Keiner ist stärker';
        }
        break;
      case ActionType.defend:
        ownAttackSentence = 'Du verteidigst mit ${widget.ownCard.name}.';
        switch (widget.result) {
          case TurnResult.beats:
            points = 'Deine Verteidigung ist stärker';
          case TurnResult.beaten:
            points = 'Deine Verteidigung reicht nicht aus';
          case TurnResult.draw:
            points = 'Keiner ist stärker';
        }
        break;
      case ActionType.escape:
        ownAttackSentence = 'Du fliehst mit ${widget.ownCard.name}.';
        switch (widget.result) {
          case TurnResult.beats:
            points = 'Du bist schneller';
          case TurnResult.beaten:
            points = 'Du bist zu langsam';
          case TurnResult.draw:
            points = 'Ihr seid gleich schnell';
        }
    }
    if (widget.ownCard.cardElement.beats(widget.oponentCard.cardElement)) {
      elementAdvantage =
          '${widget.ownCard.cardElement.asString} schlägt ${widget.oponentCard.cardElement.asString} deines Gegners. Gegners hat nur noch ${widget.oponentCard.cardLevel.lowerElement.asString}-Werte';
    } else {
      if (widget.ownCard.cardElement
          .isBeatenBy(widget.oponentCard.cardElement)) {
        elementAdvantage =
            '${widget.ownCard.cardElement.asString} wird durch ${widget.oponentCard.cardElement.asString} deines Gegners geschlagen. Du hast nur noch ${widget.ownCard.cardLevel.lowerElement.asString}-Werte';
      }
    }

    return Column(
      children: [
        Visibility(
          visible: visibility[0],
          child: Text(
            ownAttackSentence,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Visibility(
          visible: visibility[1],
          child: Text(
            'Der Gegner setzt ${widget.oponentCard.name} gegen deine Aktion ein.',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Visibility(
          visible: visibility[2],
          child: Text(
            elementAdvantage,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Visibility(
          visible: visibility[3],
          child: Text(
            points,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ],
    );
  }

  Column getContentOponentTurn() {
    String oponentAttackSentence = '';
    String elementAdvantage = 'Kein Element schlägt das andere';
    String points = '';
    switch (widget.actionType) {
      case ActionType.attack:
        oponentAttackSentence =
            'Gegner greift mit ${widget.oponentCard.name} an';
        switch (widget.result) {
          case TurnResult.beats:
            points = "Deine Verteidigung hält stand";
          case TurnResult.beaten:
            points = "Deine Verteidigung ist zu schwach";
          case TurnResult.draw:
            points = "Keiner kann gewinnen";
        }
        break;
      case ActionType.defend:
        oponentAttackSentence =
            'Gegner verteidigt mit ${widget.oponentCard.name}.';
        switch (widget.result) {
          case TurnResult.beats:
            points = "Du schlägst die Verteitigung!";
          case TurnResult.beaten:
            points = "Die Verteidigung des Gegners ist zu stark";
          case TurnResult.draw:
            points = "Keiner kann gewinnen";
        }
        break;
      case ActionType.escape:
        oponentAttackSentence = 'Gegner flieht mit ${widget.oponentCard.name}.';
        switch (widget.result) {
          case TurnResult.beats:
            points = "Du bist schneller und gewinnst!";
          case TurnResult.beaten:
            points = "Du bist zu langsam und verlierst";
          case TurnResult.draw:
            points = "Beide sind gleich schnell";
        }
    }
    if (widget.ownCard.cardElement.beats(widget.oponentCard.cardElement)) {
      elementAdvantage =
          'Dein Element ${widget.ownCard.cardElement.asString} schlägt das Element ${widget.oponentCard.cardElement.asString} deines Gegners. Die ${widget.oponentCard.cardLevel.asString}-Karte des Gegners hat nur noch die ${widget.oponentCard.cardLevel.lowerElement.asString}-Werte';
    } else {
      if (widget.ownCard.cardElement
          .isBeatenBy(widget.oponentCard.cardElement)) {
        elementAdvantage =
            'Dein Element ${widget.ownCard.cardElement.asString} wird durch das Element ${widget.oponentCard.cardElement.asString} deines Gegners geschlagen. Deine ${widget.ownCard.cardLevel.asString}-Karte hat nur noch die ${widget.oponentCard.cardLevel.lowerElement.asString}-Werte';
      }
    }
    return Column(
      children: [
        Visibility(
          visible: visibility[0],
          child: Text(
            oponentAttackSentence,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Visibility(
          visible: visibility[1],
          child: Text(
            'Du setzt ${widget.ownCard.name} gegen deinen Gegner ein.',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Visibility(
          visible: visibility[2],
          child: Text(
            elementAdvantage,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Visibility(
          visible: visibility[3],
          child: Text(
            points,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: getTitle(),
      content: SingleChildScrollView(
        child: widget.ownTurn ? getContentOwnTurn() : getContentOponentTurn(),
      ),
      backgroundColor: Colors.transparent,
      /* result == TurnResult.beats
          ? Colors.green.shade100
          : result == TurnResult.beaten
              ? Colors.red.shade100
              : Colors.yellow.shade100, */
    );
  }
}
