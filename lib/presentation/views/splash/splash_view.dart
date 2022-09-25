import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/views/bottom_nav_bar/bottom_nav_bar.dart';
import '../../../config/front_end_config.dart';
import '../../../navigation_helper/navigation_helper.dart';
import '../auth/login/login_view.dart';
import 'layout/splash_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      _checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: FrontEndConfigs.kBgColor,
      body: SplashBody(),
    );
  }

  _checkUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      NavigationHelper.pushReplacement(context, const BottomNavBody());
    } else {
      NavigationHelper.pushReplacement(context, const LoginView());
    }
  }
}
