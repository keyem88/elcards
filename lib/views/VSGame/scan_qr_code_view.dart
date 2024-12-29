import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:myapp/controller/game_controller.dart';
import 'package:myapp/utils/constants/app_constants.dart';

import '../../models/User/user.dart';

class ScanQRCodeView extends StatelessWidget {
  ScanQRCodeView({
    Key? key,
    required this.user,
  }) : super(key: key);

  final ElCardsUser user;
  //GameController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<GameController>(
      builder: (controller) => !controller.cameraPermission.value
          ? Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const CircularProgressIndicator(),
                    ElevatedButton(
                      onPressed: () {
                        controller.clickCancelButton();
                      },
                      child: const Text(
                        'Cancel',
                      ),
                    ),
                  ]),
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
      init: GameController(user: user, deviceType: DeviceType.browser),
    ));
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
