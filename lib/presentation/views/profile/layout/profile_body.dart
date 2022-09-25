import 'package:flutter/material.dart';
import 'package:k24_admin/navigation_helper/navigation_helper.dart';
import 'package:k24_admin/presentation/views/add_product/add_product.dart';
import 'package:k24_admin/presentation/views/answered_question/answered_question.dart';
import 'package:k24_admin/presentation/views/auth/change_password/change_password.dart';
import 'package:k24_admin/presentation/views/order_history/order_history.dart';
import '../../../elements/custom_text.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               const CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('assets/images/dp.png'),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.camera_alt,size: 11,color: Colors.white,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Admin',
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
              onTap: (){
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
              onTap: (){
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
          CustomText(text: 'Monthly Statement'),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: (){
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
              onTap: (){
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
          CustomText(text: 'Logout',color: Colors.red,),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
