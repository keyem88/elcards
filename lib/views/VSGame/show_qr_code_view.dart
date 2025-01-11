import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/game_controller.dart';
import 'package:myapp/models/User/user.dart';
import 'package:myapp/utils/constants/app_constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../config/themes/app_colors.dart';

class ShowQRCodeView extends GetView<GameController> {
  ShowQRCodeView({
    super.key,
    required this.user,
  });
  final ElCardsUser user;
  @override
  late GameController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(
      GameController(
        user: user,
        deviceType: DeviceType.advicer,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: controller.obx(
        (state) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                textAlign: TextAlign.center,
                'Let your component scan your Game-Code to start VS-Game',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    color: AppColors.primaryLight),
                child: QrImageView(
                  data: jsonEncode({
                    'userId': controller.user.userID,
                    'cards': jsonEncode(controller.user.cardDeck),
                    'firstTurn': jsonEncode(!controller.game.ownTurn.value),
                    'avatar': jsonEncode(controller.user.avatar),
                  }),
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              ElevatedButton(
                  onPressed: controller.clickCancelButton,
                  child: const Text('Cancel'))
            ],
          ),
        ),
      ),
    );
  }
}
