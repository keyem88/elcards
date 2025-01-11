import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/main_menu_controller.dart';
import 'package:myapp/views/Game/card_selection_view.dart';

class TrainerView extends StatelessWidget {
  TrainerView({super.key});

  final MainMenuController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CardSelectionView(
        trainerMode: true,
      ),
    );
  }
}
