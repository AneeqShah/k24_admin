import 'package:flutter/material.dart';
import '../../../../config/front_end_config.dart';
import '../../../../navigation_helper/navigation_helper.dart';
import '../../../elements/custom_text.dart';
import '../register/register_view.dart';
import 'layout/login_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: GestureDetector(
          onTap: (){
            NavigationHelper.pushRoute(context, const RegisterView());
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: 'I don\'t have an account.'),
              CustomText(text: 'Sign Up',color: FrontEndConfigs.kPrimaryColor,),
            ],
          ),
        ),
      ),
      body: LoginBody(),
    );
  }
}
