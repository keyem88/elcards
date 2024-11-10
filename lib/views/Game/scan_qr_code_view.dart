import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:myapp/controller/game_controller.dart';
import 'package:myapp/utils/constants/app_constants.dart';

import '../../models/User/user.dart';

class ScanQRCodeView extends StatelessWidget {
  ScanQRCodeView({
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
        body: GetBuilder<GameController>(
      builder: (controller) => !controller.cameraPermission.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                MobileScanner(
                  controller: controller.scannerController,
                  onDetect: controller.handleBarcode,
                  errorBuilder: (
                    BuildContext context,
                    MobileScannerException error,
                    Widget? child,
                  ) {
                    return ScannerErrorWidget(error: error);
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: controller.clickCancelButton,
                      child: const Text('Cancel')),
                )
              ],
            ),
      init: controller,
    ));

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

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({super.key, required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller not ready.';
        break;
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Permission denied';
        break;
      default:
        errorMessage = 'Generic Error';
        break;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Icon(Icons.error, color: Colors.white),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
