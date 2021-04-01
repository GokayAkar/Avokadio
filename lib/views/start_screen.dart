import 'package:flutter/material.dart';

import '../views/login_screen.dart';
import '../widgets/circular_container.dart';
import '../widgets/padding_box.dart';
import '../widgets/responsive_text.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Spacer(
                flex: 20,
              ),
              Container(
                height: screenSize.height * .25,
                width: screenSize.width * .7,
                child: FittedBox(
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/avokadio.png"),
                ),
              ),
              Spacer(
                flex: 65,
              ),
              SizedBox(
                height: screenSize.height * .06,
                child: CircularContainer.wide(
                  onPressed: () => Navigator.pushNamed(context, LoginSignUpScreen.loginPage, arguments: false),
                  text: "GET STARTED",
                  textColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              PaddingBox(),
              SizedBox(
                height: screenSize.height * .025,
                child: ResponsiveText(
                  "Already Have an Account?",
                  textColor: Colors.blue,
                ),
              ),
              SizedBox(
                height: screenSize.height * .06,
                child: CircularContainer.wide(
                  onPressed: () => Navigator.pushNamed(context, LoginSignUpScreen.loginPage, arguments: true),
                  text: "LOGIN",
                  textColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              Spacer(
                flex: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
