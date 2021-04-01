import 'package:demo_project/providers/states/create_user_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/circular_container.dart';
import '../widgets/padding_box.dart';
import '../utility.dart' as utility;

class UserCredentialsScreen extends StatefulWidget {
  UserCredentialsScreen({Key? key}) : super(key: key);
  static const String userCredentailsScreen = "/userCredentails";

  @override
  _UserCredentialsScreenState createState() => _UserCredentialsScreenState();
}

class _UserCredentialsScreenState extends State<UserCredentialsScreen> {
  final _formKey = GlobalKey<FormState>();
  int _stepperIndex = 0;

  void tapped(int step) {
    if (step > _stepperIndex) {
      utility.showSnackBar(context, "please provide necessary data first");
      return;
    }
    _stepperIndex = step;
    setState(() {});
  }

  void continued() {
    if (_stepperIndex == 0) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        _stepperIndex++;
        setState(() {});
      }
    }
    return;
    //  else {
    //   _stepperIndex++;
    //   setState(() {});
    // }
  }

  void cancel() {
    if (_stepperIndex == 0) {
      return;
    } else {
      _stepperIndex--;
      setState(() {});
    }
  }

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "field cannot be empty";
    }
    return null;
  }

  String? doubleValidator(String? value) {
    if (value!.isEmpty) {
      return "field cannot be empty";
    }
    if (value.contains(",") && value.contains(".")) {
      return "enter a valid number";
    }
    if (value.contains(".") && (value.indexOf(".") != value.lastIndexOf("."))) {
      return "enter a valid number";
    }
    if (value.contains(",") && (value.indexOf(",") != value.lastIndexOf(","))) {
      return "enter a valid number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,
      body: Consumer<GetUserCredentialsState>(
        builder: (_, value, __) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SafeArea(
              child: SingleChildScrollView(
                child: Stepper(
                  type: StepperType.vertical,
                  currentStep: _stepperIndex,
                  onStepCancel: cancel,
                  onStepContinue: continued,
                  onStepTapped: tapped,
                  steps: [
                    Step(
                      title: Text("Let's Know You"),
                      content: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text("Welcome to Avokadio Community,  \n\nWe are here to give science backed wellness and nutrition advice based on your daily routine. "),
                            PaddingBox.small(),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: "Name",
                              ),
                              validator: validator,
                              onSaved: (newValue) => value.name = newValue!,
                            ),
                            PaddingBox.small(),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: "Surname",
                              ),
                              validator: validator,
                              onSaved: (newValue) => value.surname = newValue!,
                            ),
                            PaddingBox.small(),
                            DatePickerFormField(),
                            PaddingBox.small(),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Height",
                              ),
                              validator: doubleValidator,
                              onSaved: (newValue) {
                                value.height = double.parse(newValue!.replaceAll(",", "."));
                              },
                            ),
                            PaddingBox.small(),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Weight",
                              ),
                              validator: doubleValidator,
                              onSaved: (newValue) {
                                value.weight = double.parse(newValue!.replaceAll(",", "."));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Step(
                      title: Text("Motivation"),
                      content: Column(
                        children: [
                          PaddingBox(),
                          Text("What is your primary motivation of installing this app?"),
                          PaddingBox(),
                          CircularContainer.wide(
                            text: "Lose Weight",
                            onPressed: () {
                              value.motivation = Motivation.LoseWeight;
                              _stepperIndex++;
                              setState(() {});
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          PaddingBox(),
                          CircularContainer.wide(
                            text: "Gain Muscle",
                            onPressed: () {
                              value.motivation = Motivation.GainMuscle;
                              _stepperIndex++;
                              setState(() {});
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          PaddingBox(),
                          CircularContainer.wide(
                            text: "Wellness",
                            onPressed: () {
                              value.motivation = Motivation.Wellness;
                              _stepperIndex++;
                              setState(() {});
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          PaddingBox()
                        ],
                      ),
                    ),
                    Step(
                      title: Text("Gender"),
                      content: Column(
                        children: [
                          PaddingBox(),
                          Text("What is your gender ?"),
                          PaddingBox(),
                          CircularContainer.wide(
                            text: "Male",
                            onPressed: () {
                              value.gender = "male";
                              value.addUser(context);
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          PaddingBox(),
                          CircularContainer.wide(
                            text: "Female",
                            onPressed: () {
                              value.gender = "female";
                              value.addUser(context);
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          PaddingBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class DatePickerFormField extends StatefulWidget {
  @override
  _DatePickerFormFieldState createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: "Birthday",
        enabledBorder: Theme.of(context).inputDecorationTheme.disabledBorder,
      ),
      controller: _controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "please select your birthdate";
        }
        return null;
      },
      onSaved: (newValue) => context.read<GetUserCredentialsState>().birthday = newValue!,
      readOnly: true,
      onTap: () => showDatePicker(
        context: context,
        initialDate: DateTime(1990),
        firstDate: DateTime(1930),
        lastDate: DateTime.now(),
      ).then((value) {
        if (value == null) return;
        _controller.text = DateFormat("dd.MM.yyyy").format(value);
        print(_controller.text);
        setState(() {});
      }),
    );
  }
}
