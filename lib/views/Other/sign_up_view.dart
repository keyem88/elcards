// Suggested code may be subject to a license. Learn more: ~LicenseLog:2843007504.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2004709053.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1484493068.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3760021406.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3217056271.
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:myapp/database/firebase/auth.dart';
import 'package:myapp/views/main_menu_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onSignup: FirebaseAuthentication.onSignup,
      onLogin: FirebaseAuthentication.onLogin,
      onSubmitAnimationCompleted: () {
        Get.to(
          () => MainMenuView(),
          transition: Transition.fade,
          duration: const Duration(
            milliseconds: 1000,
          ),
        );
      },
      onRecoverPassword: FirebaseAuthentication.onRecoverPassword,
      title: 'ElCards',
    );
  }
}
