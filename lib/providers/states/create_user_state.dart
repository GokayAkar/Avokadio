import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_project/models/user_credentials.dart';
import 'package:demo_project/views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo_project/utility.dart' as utility;

enum Motivation { LoseWeight, GainMuscle, Wellness }

const Map<Motivation, int> motivationDecoder = {Motivation.LoseWeight: 1, Motivation.GainMuscle: 2, Motivation.Wellness: 3};

class GetUserCredentialsState extends ChangeNotifier {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  bool isLoading = false;
  late String name;
  late String surname;
  late String birthday;
  late Motivation motivation;
  late double height;
  late double weight;
  late String gender;
  late UserCredentials newUser;

  GetUserCredentialsState(this._firestore, this._auth);

  void addUser(BuildContext context) {
    newUser = UserCredentials(birthday: birthday, gender: gender, height: height, motivation: motivationDecoder[motivation]!, name: name, surname: surname, weight: weight);
    isLoading = true;
    notifyListeners();
    try {
      _firestore.collection("users").doc(_auth.currentUser!.uid).set(newUser.toJson());
      Navigator.of(context).popAndPushNamed(HomeScreen.homeScreen, arguments: newUser);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      utility.showSnackBar(context, "message");
    }
  }
}
