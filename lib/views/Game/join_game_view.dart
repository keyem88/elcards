import 'package:flutter/material.dart';

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
