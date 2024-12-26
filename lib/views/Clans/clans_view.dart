import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../controller/main_menu_controller.dart';

class ClansView extends StatelessWidget {
  const ClansView({
    super.key,
    required this.controller,
  });

  final MainMenuController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Text(
          'ClansView',
        ),
      ),
    );
  }
}
