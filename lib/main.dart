import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/themes/app_theme.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/views/Other/initial_loading.dart';
import 'package:myapp/views/Other/sign_up_view.dart';
import 'database/firebase/auth.dart';
import 'utils/constants/app_constants.dart';
import 'views/Cards/my_cards_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: FirebaseAuthentication.isUserLogged() ? InitialLoadingView() : const SignUpView(),
    );
  }
}
