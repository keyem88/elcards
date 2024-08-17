import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myapp/models/Game/vs_game.dart';
import 'package:myapp/models/User/user.dart';
import 'package:myapp/utils/constants/app_constants.dart';

class GameController extends GetxController {
  final ElCardsUser user;
  final DeviceType deviceType;
  late VSGame game;

  Barcode? _barcode;
  Barcode? get barcode => _barcode;

  GameController({required this.deviceType, required this.user});

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int setBeginner() {
    return Random().nextInt(2);
  }

  Future<String?> createGame() async {
    DateTime now = DateTime.now();
    int pin = Random().nextInt(9999);
    List<String> players = [FirebaseAuth.instance.currentUser!.uid];
    game =
        VSGame('1', players, setBeginner(), now, pin, isHost: true);
    return null;
  }

  void handleBarcode(BarcodeCapture barcodes) {
    _barcode = barcodes.barcodes.firstOrNull;
  }
}
