import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final double widthMultiplier;
  final double heightMultiplier;
  final Function onPressed;
  final Color textColor;

  const CircularContainer({
    Key? key,
    required this.text,
    this.backgroundColor = Colors.white,
    this.widthMultiplier = .35,
    this.heightMultiplier = .06,
    required this.onPressed,
    this.textColor = Colors.blue,
  }) : super(key: key);

  const CircularContainer.wide({
    Key? key,
    required this.text,
    this.backgroundColor = Colors.white,
    this.widthMultiplier = .7,
    this.heightMultiplier = .06,
    required this.onPressed,
    this.textColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .1,
        vertical: MediaQuery.of(context).size.height * .02,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      width: _screenSize.width * widthMultiplier,
      height: _screenSize.height * heightMultiplier,
      child: InkWell(
        onTap: () => onPressed(),
        child: FittedBox(
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
