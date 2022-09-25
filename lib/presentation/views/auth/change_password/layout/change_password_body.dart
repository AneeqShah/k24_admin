import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:k24_admin/app/custom_loader.dart';
import 'package:k24_admin/presentation/elements/app_button.dart';
import 'package:k24_admin/presentation/elements/custom_text.dart';
import 'package:k24_admin/presentation/elements/custom_textfield.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({Key? key}) : super(key: key);

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  TextEditingController newPwdController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      isLoading: isLoading,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            CustomText(text: 'New Password'),
            const SizedBox(
              height: 5,
            ),
            AuthTextField(
              hint: '************',
              controller: newPwdController,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomText(text: 'Confirm Password'),
            const SizedBox(
              height: 5,
            ),
            AuthTextField(
              hint: '************',
              controller: confirmPwdController,
            ),
            const SizedBox(
              height: 40,
            ),
            AppButton(
                onPressed: () async {
                  if (newPwdController.text.trim() != "") {
                    if (newPwdController.text == confirmPwdController.text) {
                      _changePassword(newPwdController.text);
                    } else {
                      Fluttertoast.showToast(msg: "Password not match");
                    }
                  } else {
                    Fluttertoast.showToast(msg: "Password can't be empty");
                  }
                },
                text: 'Update Password'),
          ],
        ),
      ),
    );
  }

  void _changePassword(String password) async {
    loadingTrue();
    User user = await FirebaseAuth.instance.currentUser!;

    await user.updatePassword(password).then((_) {
      loadingFalse();
      Fluttertoast.showToast(msg: "Successfully changed password");
    }).catchError((error) {
      loadingFalse();
      if ("[firebase_auth/requires-recent-login] This operation is sensitive and requires recent authentication. Log in again before retrying this request." ==
          error.toString()) {
        Fluttertoast.showToast(msg: "Sensitive Data Re-login to continue");
      }
    });
  }

  loadingTrue() {
    isLoading = true;
    setState(() {});
  }

  loadingFalse() {
    isLoading = false;
    setState(() {});
  }
}
