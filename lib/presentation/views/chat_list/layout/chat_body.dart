import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/views/chat_list/layout/widgets/chat_list_tile.dart';
import 'package:k24_admin/presentation/views/chatting/chatting_view.dart';

import '../../../../navigation_helper/navigation_helper.dart';

class ChatListBody extends StatelessWidget {
  const ChatListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
         NavigationHelper.pushRoute(context, ChatView());
            },
            child: ChatListTile(title: 'Luna',
                date: '12/sep/2020',
                desc: 'when an unknown printer took a galley of type'
                'and scrambled.'),
          ),
        );
      })),
    );
  }
}
