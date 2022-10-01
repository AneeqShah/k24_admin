import 'package:flutter/material.dart';

import '../../elements/custom_app_bar.dart';
import 'layout/update_body.dart';

class UpdateProfile extends StatefulWidget {
  final String customerID;

  const UpdateProfile({super.key, required this.customerID});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Profile", showIcon: true),
      backgroundColor: Colors.white,
      body: UpdateProfileBody(
        customerID: widget.customerID,
      ),
    );
  }
}
