import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  bool showDescription;
  bool isNumberField;
  bool isPasswordField;
  bool isEnable;

  AuthTextField({
    this.isEnable = true,
    required this.hint,
    required this.controller,
    this.showDescription = false,
    this.isNumberField = false,
    this.isPasswordField = false,
    this.keyBoardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xffF0F0F0)),
        child: TextFormField(
          inputFormatters: isNumberField
              ? [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                ]
              : null,
          controller: controller,
          enabled: isEnable,
          obscureText: isPasswordField,
          keyboardType: keyBoardType,
          maxLines: showDescription ? 8 : 1,
          style: const TextStyle(
              letterSpacing: 1,
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}
