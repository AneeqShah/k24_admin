import 'package:flutter/material.dart';

import '../../../../../navigation_helper/navigation_helper.dart';
import '../../../../elements/app_button.dart';
import '../../../../elements/custom_text.dart';
import '../../../../elements/custom_textfield.dart';
import '../../../bottom_nav_bar/bottom_nav_bar.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController pwdController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          Center(child: Image.asset('assets/images/logo1.png')),
          SizedBox(height: 30,),
          CustomText(text: 'Sign in',fontSize: 22,fontWeight: FontWeight.w600,),
          const SizedBox(height: 10,),
          CustomText(
            text: 'Welcome to Kartenlegen24\nLogin to continue',
            fontSize: 11,
             fontWeight: FontWeight.w300,
          ),
          const SizedBox(height: 25,),
          CustomText(text: 'Email'),
          AuthTextField(hint: 'user@gmail.com', controller: emailController),
          const SizedBox(height: 15,),
          CustomText(text: 'Password'),
          AuthTextField(hint: '**********', controller: pwdController),
          const SizedBox(height: 10,),
          Align(
              alignment: Alignment.bottomRight,
              child: CustomText(text: 'Forgot Password?',fontWeight: FontWeight.w500,)),
          const SizedBox(height: 30,),
          AppButton(onPressed: (){
            NavigationHelper.pushRoute(context, BottomNavBody());
          }, text: 'Login'),
        ],
      ),
    );
  }
}
