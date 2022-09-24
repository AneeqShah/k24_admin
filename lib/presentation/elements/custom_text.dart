import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;
  Color? color;
  double fontSize;
  double letterSpacing;
  double? height;
  TextAlign? align;
  FontWeight fontWeight;

  CustomText(
      {required this.text,
        this.color,
        this.align,
        this.fontSize = 14,
        this.height = 1.3,
        this.letterSpacing = 1.2,
        this.fontWeight = FontWeight.w500});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      overflow: TextOverflow.visible,
      style: TextStyle(

        height: height,
        color: color,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
      ),
    );
  }
}