import 'dart:developer';

import 'package:demo_project/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utility.dart' as utility;
import '../../views/user_credentials_screen.dart';

class LoginState extends ChangeNotifier {
  final FirebaseAuth _auth;
  bool isLoading = false;

  LoginState(this._auth);

  void signUp(String email, String password, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      log(userCredential.toString());
      Navigator.of(context).pushNamedAndRemoveUntil(UserCredentialsScreen.userCredentailsScreen, (route) => route.settings.name == UserCredentialsScreen.userCredentailsScreen);
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        isLoading = false;
        notifyListeners();
        utility.showSnackBar(context, "Password is too weak");
      } else if (e.code == 'email-already-in-use') {
        isLoading = false;
        notifyListeners();
        utility.showSnackBar(context, "Email is already in use.");
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      utility.showSnackBar(context, "Something went wrong.");
    }
  }

  void singInWithGoogle(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      log(userCredential.toString());
      if (userCredential.additionalUserInfo!.isNewUser) {
        Navigator.of(context).pushNamedAndRemoveUntil(UserCredentialsScreen.userCredentailsScreen, (route) => route.settings.name == UserCredentialsScreen.userCredentailsScreen);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.homeScreen, (route) => route.settings.name == HomeScreen.homeScreen);
      }
      return;
    } on FirebaseAuthException catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
      utility.showSnackBar(context, e.message ?? "Something went wrong");
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
      utility.showSnackBar(context, "Something went wrong.");
    }
  }

  void signInWithMail(BuildContext context, String mail, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: mail, password: password);
      log(userCredential.toString());
      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.homeScreen, (route) => route.settings.name == HomeScreen.homeScreen);
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        utility.showSnackBar(context, "User does not exist.");
      } else if (e.code == 'wrong-password') {
        isLoading = false;
        notifyListeners();
        utility.showSnackBar(context, "Incorrect password");
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      utility.showSnackBar(context, "Something went wrong.");
    }
  }
}
