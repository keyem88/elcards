import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myapp/controller/game_controller.dart';

class JoinGameView extends StatelessWidget {
  JoinGameView({super.key, required this.controller});

  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MobileScanner(
            onDetect: controller.handleBarcode,
          ),
    );
  }
}
