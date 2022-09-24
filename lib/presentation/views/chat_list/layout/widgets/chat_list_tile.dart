import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/custom_text.dart';

class ChatListTile extends StatelessWidget {
  String title;
  String date;
  String desc;

  ChatListTile({required this.title, required this.date, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
          isThreeLine: false,
          minLeadingWidth: 20,
          horizontalTitleGap: 10,
          title: CustomText(
            text: title,
          ),
          subtitle: CustomText(
            text: desc,
            fontSize: 11,
            fontWeight: FontWeight.w300,
          ),
          trailing: CustomText(
            text: date,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        Divider()
      ],
    );
  }
}
