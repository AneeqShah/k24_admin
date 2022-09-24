import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/app_button.dart';
import 'package:k24_admin/presentation/elements/custom_text.dart';

class BuildTextField extends StatelessWidget {
  const BuildTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(flex: 3,
            child: Container(
              height: 120,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextFormField(

                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your answer here',
                      hintStyle: TextStyle(
                        fontSize: 11,

                      )

                    ),
                  ),
                ),
              ),
            ),
          ),
          const Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xffECBEEB),
            child: Icon(Icons.arrow_forward,color: Colors.white,),
          ))
        ],
      ),

    );
  }
}
