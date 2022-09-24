import 'package:flutter/material.dart';

class NavigationHelper {
  static pushReplacement(BuildContext context, Widget targetClass) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>targetClass));
  }

  static pushRoute(BuildContext context, Widget targetClass) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>targetClass));
  }

  static removeAllRoutes(BuildContext context, Widget targetClass) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => targetClass), (route) => false);
  }
}