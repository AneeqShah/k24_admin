import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:k24_admin/app/custom_loader.dart';

import '../../../../../navigation_helper/navigation_helper.dart';
import '../../../../elements/app_button.dart';
import '../../../../elements/custom_text.dart';
import '../../../../elements/custom_textfield.dart';
import '../../../bottom_nav_bar/bottom_nav_bar.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
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
              height: 50,
            ),
            Center(child: Image.asset('assets/images/logo1.png')),
            const SizedBox(
              height: 30,
            ),
            CustomText(
              text: 'Sign in',
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomText(
              text: 'Welcome to Kartenlegen24\nLogin to continue',
              fontSize: 11,
              fontWeight: FontWeight.w300,
            ),
            const SizedBox(
              height: 25,
            ),
            CustomText(text: 'Email'),
            AuthTextField(hint: 'user@gmail.com', controller: _email),
            const SizedBox(
              height: 15,
            ),
            CustomText(text: 'Password'),
            AuthTextField(hint: '**********', controller: _password),
            const SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: CustomText(
                  text: 'Forgot Password?',
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 30,
            ),
            AppButton(
                onPressed: () {
                  _adminLogin();
                },
                text: 'Login'),
          ],
        ),
      ),
    );
  }

  _adminLogin() async {
    try {
      loadingTrue();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _email.text, password: _password.text)
          .then((value) async {
        if (FirebaseAuth.instance.currentUser!.uid ==
            "NaupTnYfJcXauqE54QtRm0n9yPV2") {
          loadingFalse();
          NavigationHelper.pushReplacement(context, BottomNavBody());
        } else {
          loadingFalse();
          Fluttertoast.showToast(msg: "You are not admin");
          await FirebaseAuth.instance.signOut();
        }
      });
    } on FirebaseException catch (e) {
      loadingFalse();
      Fluttertoast.showToast(msg: e.message!);
    }
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
