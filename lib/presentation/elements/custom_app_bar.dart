import 'package:flutter/material.dart';
import 'custom_text.dart';

customAppBar(String text,{
  bool showIcon = false,
}){
  return AppBar(
    title: CustomText(text: text,color: Colors.black,),
    elevation: 0,
    centerTitle: true,
    automaticallyImplyLeading: showIcon?true:false,
    backgroundColor: Colors.white,

    iconTheme: const IconThemeData(
      color: Colors.black
    ),

  );
}