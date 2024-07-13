import 'package:flutter/material.dart';
import 'views/main_menu_view.dart';

void main() {
  /*await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Cards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainMenuView(),
    );
  }
}