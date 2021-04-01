import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final Alignment alignment;
  final Color textColor;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  const ResponsiveText(
    this.text, {
    Key? key,
    this.alignment = Alignment.center,
    this.textAlign = TextAlign.center,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
