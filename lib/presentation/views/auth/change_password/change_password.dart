import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/views/auth/change_password/layout/change_password_body.dart';

import '../../../elements/custom_app_bar.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        'Change Password',
        showIcon: true
      ),
      body: ChangePasswordBody(),
    );
  }
}
