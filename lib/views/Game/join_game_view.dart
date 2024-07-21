import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/game_controller.dart';
import 'package:myapp/models/User/user.dart';

class JoinGameView extends StatelessWidget {
  JoinGameView({super.key, this.controller});

  final controller;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Join Game",
      ),
    );
  }
}
