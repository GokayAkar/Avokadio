import 'package:demo_project/providers/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../views/user_credentials_screen.dart';
import '../widgets/circular_container.dart';
import '../widgets/padding_box.dart';
import '../widgets/responsive_text.dart';

class LoginSignUpScreen extends StatefulWidget {
  LoginSignUpScreen({Key? key}) : super(key: key);
  static const String loginPage = '/login';

  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _mailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordControlController;

  double opacity = 0;

  void _submit(bool isLogin) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (isLogin) {
      context.read<LoginState>().signInWithMail(context, _mailController.text.trim(), _passwordController.text.trim());
    } else {
      context.read<LoginState>().signUp(_mailController.text.trim(), _passwordController.text.trim(), context);
    }
  }

  @override
  void initState() {
    _mailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordControlController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    _passwordControlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    final bool _isLogin = ModalRoute.of(context)!.settings.arguments as bool;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: context.watch<LoginState>().isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                physics: MediaQuery.of(context).viewInsets.bottom == 0 ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  width: _screenSize.width,
                  height: _screenSize.height - MediaQuery.of(context).viewInsets.bottom * 0.8,
                  child: Column(
                    children: [
                      Spacer(
                        flex: 20,
                      ),
                      AnimatedOpacity(
                        opacity: opacity,
                        duration: Duration(milliseconds: 500),
                        child: Container(
                          width: _screenSize.width * .8,
                          padding: EdgeInsets.symmetric(
                            horizontal: _screenSize.width * .075,
                            vertical: _screenSize.height * .05,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _mailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: "E-Mail",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "E-mail cannot be empty";
                                    } else if (!value.contains("@")) {
                                      return "Invalid e-mail";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                PaddingBox(),
                                TextFormField(
                                  controller: _passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  onFieldSubmitted: (value) {
                                    if (!_isLogin) {
                                    } else {
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                  decoration: InputDecoration(labelText: "Password"),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Password cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                if (!_isLogin) PaddingBox(),
                                if (!_isLogin)
                                  TextFormField(
                                    controller: _passwordControlController,
                                    keyboardType: TextInputType.visiblePassword,
                                    //onSubmitted: (value) => FocusNode().requestFocus(passwordNode), login
                                    decoration: InputDecoration(labelText: "Password Check"),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "E-mail cannot be empty";
                                      } else if (value.trim() != _passwordController.text.trim()) {
                                        return "Password don't match";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                PaddingBox(),
                                ElevatedButton(
                                  onPressed: () => _submit(_isLogin),
                                  child: Text(_isLogin ? "Login" : "Sign Up"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 15,
                      ),
                      SizedBox(
                        height: _screenSize.height * .03,
                        child: ResponsiveText(
                          _isLogin ? "Login with" : "Continue with",
                        ),
                      ),
                      PaddingBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularContainer(
                            text: "Google",
                            onPressed: () {
                              if (_isLogin) {
                                context.read<LoginState>().singInWithGoogle(context);
                              } else {
                                opacity = 1;
                                setState(() {});
                              }
                            },
                          ),
                          CircularContainer(
                            text: "E-Mail",
                            onPressed: () {
                              opacity = 1;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      Spacer(
                        flex: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
