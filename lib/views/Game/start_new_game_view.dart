import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:myapp/controller/game_controller.dart';
import 'package:myapp/utils/constants/app_constants.dart';

import '../../models/User/user.dart';

class StartNewGameView extends StatelessWidget {
  StartNewGameView({
    super.key,
    required this.user,
  }) {
    controller = Get.put(GameController(
      deviceType: DeviceType.browser,
      user: user,
    ));
  }

  final ElCardsUser user;
  GameController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (!controller!.cameraPermission.value) {
          return Center(
            child: Text('No Camera-Permission'),
          );
        }
        return Stack(
          children: [
            MobileScanner(
              controller: controller!.scannerController,
              onDetect: controller!.handleBarcode,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: controller!.clickCancelButton,
                  child: Text('Cancel')),
            )
          ],
        );
      }),
    );

    /*ListView.builder(
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              controller.connectToDevice(controller.devices[index].deviceName,
                  controller.devices[index].deviceId);
            },
            child: ListTile(
              title: Text(controller.devices[index].deviceName),
              subtitle:
                  controller.devices[index].state == SessionState.connected
                      ? Text('Connected')
                      : Text('Not Connected'),
              tileColor:
                  controller.devices[index].state == SessionState.connected
                      ? Colors.green
                      : Colors.white,
            ),
          ),
          itemCount: controller.devices.length,
        );*/
  }
}
