import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:k24_admin/navigation_helper/navigation_helper.dart';
import 'package:k24_admin/presentation/views/add_product/add_product.dart';
import 'package:k24_admin/presentation/views/answered_question/answered_question.dart';
import 'package:k24_admin/presentation/views/auth/change_password/change_password.dart';
import 'package:k24_admin/presentation/views/order_history/order_history.dart';
import '../../../elements/custom_text.dart';
import '../../auth/login/login_view.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('assets/images/logo.png'),
                child: Align(
                  alignment: Alignment.bottomRight,

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Hello, Admin',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
              onTap: () {
                NavigationHelper.pushRoute(context, OrderHistoryView());
              },
              child: CustomText(text: 'Order History')),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {
                NavigationHelper.pushRoute(context, AnsweredQuestionView());
              },
              child: CustomText(text: 'Answered Question')),
          const SizedBox(
            height: 10,
          ),
      
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {
                NavigationHelper.pushRoute(context, AddProduct());
              },
              child: CustomText(text: 'Add Product')),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {
                NavigationHelper.pushRoute(context, ChangePassword());
              },
              child: CustomText(text: 'Change Password')),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () {
                _logout();
              },
              child: CustomText(
                text: 'Logout',
                color: Colors.red,
              )),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
        ],
      ),
    );
  }

  _logout() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        NavigationHelper.pushReplacement(context, LoginView());
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }
}
