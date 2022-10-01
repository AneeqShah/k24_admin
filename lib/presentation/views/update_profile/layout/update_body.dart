import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../app/custom_loader.dart';
import '../../../../config/front_end_config.dart';
import '../../../elements/Custom_image_container.dart';
import '../../../elements/custom_text.dart';
import '../../../elements/custom_textfield.dart';

enum Gender { male, female }

class UpdateProfileBody extends StatefulWidget {
  final String customerID;

  const UpdateProfileBody({super.key, required this.customerID});

  @override
  State<UpdateProfileBody> createState() => _UpdateProfileBodyState();
}

class _UpdateProfileBodyState extends State<UpdateProfileBody> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController zodiacController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  String image = "";
  bool gender = false;
  bool isLoading = false;
  String userID = FirebaseAuth.instance.currentUser!.uid;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    _getUserID();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      isLoading: isLoading,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Column(
                  children: [
                    CustomImageContainer(
                      height: 110,
                      wight: 110,
                      radius: 500,
                      image: image,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomText(
                text: 'Full Name',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              AuthTextField(
                  isEnable: false,
                  hint: 'Not added by user',
                  controller: nameController),
              const SizedBox(
                height: 15,
              ),
              CustomText(
                text: 'Email',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              AuthTextField(
                  isEnable: false, hint: 'Email', controller: emailController),
              const SizedBox(
                height: 15,
              ),
              CustomText(
                text: 'Date of Birth',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: dobController.text == ""
                              ? "Not Added yet"
                              : dobController.text),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomText(
                text: 'Zodiac',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              AuthTextField(
                  isEnable: false,
                  hint: 'Not added by user',
                  controller: zodiacController),
              const SizedBox(
                height: 15,
              ),
              CustomText(
                text: 'Country',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              AuthTextField(
                  isEnable: false,
                  hint: 'Not added by user',
                  controller: countryController),
              const SizedBox(
                height: 15,
              ),
              CustomText(
                text: 'Gender',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              AuthTextField(
                  isEnable: false,
                  hint: 'Gender',
                  controller: genderController),
            ],
          ),
        ),
      ),
    );
  }

  _getUserID() async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.customerID)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      nameController.text = snapshot.get("name");
      image = snapshot.get("image");
      emailController.text = snapshot.get("email");
      zodiacController.text = snapshot.get("zodiac");
      countryController.text = snapshot.get("country");
      dobController.text = snapshot.get("dob");
      genderController.text = snapshot.get("isMale") ? "Male" : "Female";
      setState(() {});
    });
  }
}
