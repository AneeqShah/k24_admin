import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/app_button.dart';
import 'package:k24_admin/presentation/elements/custom_text.dart';

class BuildTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function onSend;
  final Function onImage;

  const BuildTextField(
      {super.key, required this.controller, required this.onSend, required this.onImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 120,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextFormField(
                    maxLines: 100,
                    controller: controller,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your answer here',
                        hintStyle: TextStyle(
                          fontSize: 11,
                        )),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: InkWell(
                onTap: () => onImage(),
                child: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xffECBEEB),
                  child: Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                ),
              )),
          Expanded(
              child: InkWell(
                onTap: () => onSend(),
                child: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xffECBEEB),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
