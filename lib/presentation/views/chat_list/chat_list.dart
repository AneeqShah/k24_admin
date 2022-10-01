import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/custom_app_bar.dart';

import 'layout/chat_body.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar('Question to answer'),
      body: const ChatListBody(),
    );
  }
}
