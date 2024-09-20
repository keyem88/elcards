import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/game_controller.dart';
import 'package:myapp/models/User/user.dart';
import 'package:myapp/utils/constants/app_constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class JoinGameView extends StatelessWidget {
  JoinGameView({
    super.key,
    required this.user,
  }) {
    controller = Get.put(GameController(
      deviceType: DeviceType.advicer,
      user: user,
    ));
  }

  final ElCardsUser user;
  GameController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Obx(() {
        if (controller!.finishInit.value) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                textAlign: TextAlign.center,
                'Let your component scan your Game-Code',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              QrImageView(
                data: jsonEncode({
                  'userId': controller!.user.userID,
                  'cards': jsonEncode(controller!.user.cardDeck)
                }),
                version: QrVersions.auto,
                size: 200.0,
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      })),
    );
  }
}
