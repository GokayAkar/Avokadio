import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_project/providers/states/create_user_state.dart';
import 'package:demo_project/providers/states/home_screen_state.dart';
import 'package:demo_project/providers/states/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './views/home_screen.dart';
import './views/user_credentials_screen.dart';
import './views/login_screen.dart';

final routes = {
  LoginSignUpScreen.loginPage: (BuildContext context) => ChangeNotifierProvider<LoginState>(
        create: (_) => LoginState(context.read<FirebaseAuth>()),
        child: LoginSignUpScreen(),
      ),
  UserCredentialsScreen.userCredentailsScreen: (BuildContext context) => ChangeNotifierProvider<GetUserCredentialsState>(
        create: (_) => GetUserCredentialsState(context.read<FirebaseFirestore>(), context.read<FirebaseAuth>()),
        child: UserCredentialsScreen(),
      ),
  // ignore: top_level_function_literal_block
  HomeScreen.homeScreen: (BuildContext context) {
    return ChangeNotifierProvider<HomeScreenState>(create: (context) => HomeScreenState(context.read<FirebaseFirestore>(), context.read<FirebaseAuth>(), context), child: HomeScreen());
  }
};
