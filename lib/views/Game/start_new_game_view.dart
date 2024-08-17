import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/controller/game_controller.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class StartNewGameView extends StatelessWidget {
  const StartNewGameView({
    super.key,
    required this.controller,
  });

  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PrettyQrView.data(
          data: jsonEncode(
            controller.game.asMap(),
          ),
        ),
      ),
    );
  }
}
