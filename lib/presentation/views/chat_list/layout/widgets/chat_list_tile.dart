import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/Custom_image_container.dart';
import 'package:k24_admin/presentation/elements/custom_text.dart';

class ChatListTile extends StatelessWidget {
  String title;
  String image;

  ChatListTile(
      {required this.title,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CustomImageContainer(
              height: 50, wight: 50, radius: 500, image: image),
          isThreeLine: false,
          minLeadingWidth: 20,
          horizontalTitleGap: 10,
          title: CustomText(
            text: title,
          ),
          // trailing: CustomText(
          //   text: date,
          //   fontWeight: FontWeight.w400,
          //   fontSize: 12,
          // ),
        ),
        Divider()
      ],
    );
  }
}
