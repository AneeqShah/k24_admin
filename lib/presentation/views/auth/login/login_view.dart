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
    return  const Scaffold(
      backgroundColor: Colors.white,
      body: LoginBody(),
    );
  }
}
