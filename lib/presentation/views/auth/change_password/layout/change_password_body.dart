import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/app_button.dart';
import 'package:k24_admin/presentation/elements/custom_text.dart';
import 'package:k24_admin/presentation/elements/custom_textfield.dart';

class ChangePasswordBody extends StatelessWidget {
  const ChangePasswordBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController oldPwdController = TextEditingController();
    TextEditingController newPwdController = TextEditingController();
    TextEditingController confirmPwdController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          CustomText(text: 'Old Password'),
          const SizedBox(height: 5,),
          AuthTextField(hint: '************', controller: oldPwdController),
          const SizedBox(height: 10,),
          CustomText(text: 'New Password'),
          const SizedBox(height: 5,),
          AuthTextField(hint: '************', controller: newPwdController
          ),
          const SizedBox(height: 10,),
          CustomText(text: 'Confirm Password'),
          const SizedBox(height: 5,),
          AuthTextField(hint: '************', controller: confirmPwdController),
          const SizedBox(height: 40,),
          AppButton(onPressed: (){}, text: 'Update Password'),

        ],
      ),
    );
  }
}
