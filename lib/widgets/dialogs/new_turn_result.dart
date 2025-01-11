import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/widgets/cards/card_widget.dart';

import '../../models/Card/playing_card.dart';
import '../../utils/constants/app_constants.dart';

class NewTurnResult extends StatefulWidget {
  const NewTurnResult(
      {super.key,
      required this.result,
      required this.ownCard,
      required this.oponentCard,
      required this.actionType,
      required this.ownTurn,
      required this.ownValue,
      required this.oponentValue});

  final TurnResult result;
  final PlayingCard ownCard;
  final PlayingCard oponentCard;
  final ActionType actionType;
  final bool ownTurn;
  final int ownValue;
  final int oponentValue;

  @override
  State<NewTurnResult> createState() => _NewTurnResultState();
}

class _NewTurnResultState extends State<NewTurnResult> {
  final bool _ownvisible = true;
  bool _oponentvisible = false;
  bool _oponentAttackVisible = false;
  bool _oponentDefenseVisible = false;
  bool _oponentSpeedVisible = false;
  bool _ownAttackVisible = false;
  bool _ownDefenseVisible = false;
  bool _ownSpeedVisible = false;
  bool _showLowerOwnAttribute = false;
  bool _showLowerOponentAttribute = false;
  bool _resultVisible = false;
  Color? _ownLevelColor;
  Color? _oponentLevelColor;

  @override
  void initState() {
    super.initState();

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _oponentvisible = true;
      });
    });

    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        checkAttributCircleVisibility();
      });
    });

    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        checkElements();
      });
    });

    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _resultVisible = true;
      });
    });

    await Future.delayed(Duration(seconds: 2), () {
      Get.back();
    });
  }

  void checkElements() {
    if (widget.ownCard.cardElement.isBeatenBy(widget.oponentCard.cardElement)) {
      _ownLevelColor = Colors.grey;
      _oponentLevelColor = Colors.red;
      _showLowerOwnAttribute = true;
    } else if (widget.ownCard.cardElement
        .beats(widget.oponentCard.cardElement)) {
      _ownLevelColor = Colors.red;
      _oponentLevelColor = Colors.grey;
      _showLowerOponentAttribute = true;
    } else {
      _ownLevelColor = Colors.yellow;
      _oponentLevelColor = Colors.yellow;
    }
  }

  void checkAttributCircleVisibility() {
    if (widget.ownTurn) {
      debugPrint('ownTurn');
      if (widget.actionType == ActionType.attack) {
        debugPrint('attack');
        _ownAttackVisible = true;
        _oponentDefenseVisible = true;
      } else if (widget.actionType == ActionType.defend) {
        debugPrint('defend');
        _ownDefenseVisible = true;
        _oponentAttackVisible = true;
      } else if (widget.actionType == ActionType.escape) {
        debugPrint('escape');
        _ownSpeedVisible = true;
        _oponentSpeedVisible = true;
      }
    } else {
      debugPrint('oponentTurn');
      if (widget.actionType == ActionType.attack) {
        debugPrint('attack');
        _oponentAttackVisible = true;
        _ownDefenseVisible = true;
      } else if (widget.actionType == ActionType.defend) {
        debugPrint('defend');
        _oponentDefenseVisible = true;
        _ownAttackVisible = true;
      } else if (widget.actionType == ActionType.escape) {
        debugPrint('escape');
        _oponentSpeedVisible = true;
        _ownSpeedVisible = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black.withOpacity(
          0.7,
        ),
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: AnimatedOpacity(
                    opacity: _ownvisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: CardWidget(
                      attackVisible: _ownAttackVisible,
                      defenseVisible: _ownDefenseVisible,
                      speedVisible: _ownSpeedVisible,
                      height: Get.height / 2,
                      card: widget.ownCard,
                      levelColor: _ownLevelColor,
                      lowerAttribute: _showLowerOwnAttribute,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: AnimatedOpacity(
                    opacity: _oponentvisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: CardWidget(
                      attackVisible: _oponentAttackVisible,
                      defenseVisible: _oponentDefenseVisible,
                      speedVisible: _oponentSpeedVisible,
                      height: Get.height / 2,
                      card: widget.oponentCard,
                      levelColor: _oponentLevelColor,
                      lowerAttribute: _showLowerOponentAttribute,
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: _resultVisible,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: Get.height / 5,
                  width: Get.width,
                  color: Colors.black.withOpacity(
                    0.5,
                  ),
                  child: Center(
                    child: widget.result == TurnResult.beaten
                        ? Text(
                            'Runde verloren',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 26),
                          )
                        : widget.result == TurnResult.beats
                            ? Text(
                                'Runde gewonnen',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26),
                              )
                            : Text(
                                'Unentschieden',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26),
                              ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
