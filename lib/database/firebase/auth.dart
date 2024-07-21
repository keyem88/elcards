import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:myapp/database/firebase/firestore_database.dart';

class FirebaseAuthentication {
  //Method to sign up user in Firebase
  static Future<String?>? onSignup(SignupData data) async {
    if (data.name!.isEmpty || data.password!.isEmpty) {
      return "Please fill all the fields";
    }
    var firebase = FirebaseAuth.instance;
    try {
      //Create user in Firebase
      UserCredential userCredantials =
          await firebase.createUserWithEmailAndPassword(
        email: data.name!,
        password: data.password!,
      );
      //Add user to Firestore
      FirestoreDatabase.newUser(userCredantials);
    } on FirebaseAuthException catch (e) {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1455093050.
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        return 'The account already exists for that email.';
      } else {
        debugPrint(e.message);
        return e.message;
      }
    }
    return null;
  }

  //Method to sign in user in Firebase
  static Future<String?>? onLogin(LoginData data) async {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:4100991179.
    var firebase = FirebaseAuth.instance;
    if (data.name.isEmpty || data.password.isEmpty) {
      return "Please fill all the fields";
    }
    String email = data.name;
    String password = data.password;
    try {
      await firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2644681854.
      if (e.code == 'invalid-credential') {
        debugPrint('invalid-credential');
        return 'Your Login credentials are invalid.';
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        return 'Wrong password provided for that user.';
      }
    }
    return null;
  }

  //Method to sign out user in Firebase
  static Future<void> signOut() async {
    var firebase = FirebaseAuth.instance;
    await firebase.signOut();
  }

  //Method to reset password
  static Future<String?> onRecoverPassword(String email) async {
    var firebase = FirebaseAuth.instance;
    await firebase.sendPasswordResetEmail(email: email);
    return null;
  }

  //Check User already logged in
  static bool isUserLogged() {
    var firebase = FirebaseAuth.instance;
    if (firebase.currentUser != null) {
      return true;
    }
    return false;
  }
}
