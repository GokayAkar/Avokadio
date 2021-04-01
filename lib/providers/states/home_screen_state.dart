import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_project/models/user_credentials.dart';
import 'package:demo_project/views/user_credentials_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreenState extends ChangeNotifier {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  bool isLoading = true;
  UserCredentials? user;
  BuildContext context;

  HomeScreenState(
    this._firestore,
    this._auth,
    this.context,
  ) {
    getUser(context);
  }

  void getUser(BuildContext context) async {
    print("a");
    final DocumentSnapshot userDoc = await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
    if (userDoc.exists) {
      user = UserCredentials.fromJson(userDoc.data()!);
      isLoading = false;
      notifyListeners();
    } else {
      Navigator.of(context).popAndPushNamed(UserCredentialsScreen.userCredentailsScreen);
    }
  }
}
