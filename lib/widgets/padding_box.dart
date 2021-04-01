import 'package:flutter/material.dart';

class PaddingBox extends StatelessWidget {
  final double heightMultiplier;
  final double widthMultiplier;

  const PaddingBox({
    Key? key,
    this.heightMultiplier = .05,
    this.widthMultiplier = .08,
  }) : super(key: key);

  const PaddingBox.small({
    Key? key,
    this.heightMultiplier = .025,
    this.widthMultiplier = .04,
  }) : super(key: key);

  const PaddingBox.big({
    Key? key,
    this.heightMultiplier = .1,
    this.widthMultiplier = .12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: _screenSize.width * widthMultiplier,
      height: _screenSize.height * heightMultiplier,
    );
  }
}
