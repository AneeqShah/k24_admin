import 'package:flutter/material.dart';

import '../../config/front_end_config.dart';

class AppButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  double width;
  double height;
  Color color;
  bool showIcon;
  Color textColor;
  Color borderColor;
  double? fontSize;

  AppButton(
      {required this.onPressed,
        required this.text,
        this.showIcon = false,
        this.fontSize,
        this.color = FrontEndConfigs.kPrimaryColor,
        this.borderColor = FrontEndConfigs.kPrimaryColor,
        this.textColor =Colors.white,
        this.width = double.infinity,
        this.height = 50});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color,
          fixedSize: Size(width, height),
          shape: RoundedRectangleBorder(
            side:  BorderSide(color: borderColor,width: 0.2),
            borderRadius: BorderRadius.circular(8),
          )),
      onPressed: onPressed,
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showIcon?const Icon(Icons.search,size: 22,color: Colors.white,):const SizedBox(),
          const SizedBox(width: 5,),
          Text(text,style: TextStyle(color: textColor,fontSize: fontSize),),
        ],
      ),
    );
  }
}