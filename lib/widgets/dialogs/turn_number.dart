import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TurnNumberDialog extends StatefulWidget {
  const TurnNumberDialog(
      {super.key, required this.round, required this.ownTurn});

  final int round;
  final bool ownTurn;

  @override
  State<TurnNumberDialog> createState() => _TurnNumberDialogState();
}

class _TurnNumberDialogState extends State<TurnNumberDialog> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  Future<void> _startTimer() async {
    Future.delayed(
      Duration(
        seconds: 2,
      ),
    ).then((_) {
      Get.close(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      elevation: 1.0,
      backgroundColor: Colors.black.withOpacity(
        0.7,
      ),
      children: [
        Text(
          textAlign: TextAlign.center,
          'RUNDE ${widget.round}',
          style: const TextStyle(fontSize: 36, color: Colors.grey),
        ),
        Text(
          textAlign: TextAlign.center,
          widget.ownTurn ? 'Du bist dran' : 'Gegner ist dran',
          style: TextStyle(
              color: widget.ownTurn ? Colors.green : Colors.red,
              fontSize: 36,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
