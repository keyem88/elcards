import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/Card/card_set.dart';
import 'package:myapp/models/User/user.dart';
import 'package:myapp/utils/constants/database_constants.dart';

class FirestoreDatabase {
  static int reads = 0;
  static int writes = 0;
  static Future<void> newUser(UserCredential user) async {
    debugPrint('newUser');
    var firestore = FirebaseFirestore.instance;
    try {
      CardSet cardSet = CardSet.initialCards();
      //Add user to Firestore
      await firestore
          .collection(DatabaseConstants.users)
          .doc(
            user.user?.uid,
          )
          .set({
        'email': user.user?.email,
      });
      writes++;
      //Add cards to Firestore
      for (var card in cardSet.cards) {
        await firestore
            .collection(DatabaseConstants.users)
            .doc(user.user?.uid)
            .collection(DatabaseConstants.cards)
            .add(
              card.toJson(),
            );
        writes++;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }
    debugPrint('newUser: reads: $reads, writes: $writes');
  }

  static Future<ElCardsUser?> getUser(String userID) async {
    debugPrint('getUser');
    var firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot userSnapshot = await firestore
          .collection(
            DatabaseConstants.users,
          )
          .doc(
            userID,
          )
          .get();
      reads++;
      if (!userSnapshot.exists) {
        return null;
      }
      QuerySnapshot cardSnapshot = await firestore
          .collection(
            DatabaseConstants.users,
          )
          .doc(
            userID,
          )
          .collection(
            DatabaseConstants.cards,
          )
          .get();
      reads++;
      debugPrint('getUser: reads: $reads, writes: $writes');

      return ElCardsUser.fromSnapshot(userSnapshot, cardSnapshot);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
