

import 'package:flutter/cupertino.dart';

import '../../../../model/message.dart';
import '../widgets/build_texfield.dart';
import '../widgets/chat_message.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({Key? key}) : super(key: key);

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}
final List<Message> messages = [
  Message(0,
      'Lorem Ipsum is simply dummy text of the'
      'printing and typesetting industry. Lorem'
      'Ipsum has been the industry’s'
      'standard dummy text ever since the 1500s,'
      'when an unknown printer took a galley of type'
      'and scrambled it to make a type specimen'
      'book.'),
  Message(1,  'Lorem Ipsum is simply dummy text of the'
      'printing and typesetting industry. Lorem'
      'Ipsum has been the industry’s'
      'standard dummy text ever since the 1500s,'
      'when an unknown printer took a galley of type'
      'and scrambled it to make a type specimen'
      'book.'),
];
class _ChatViewBodyState extends State<ChatViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20,),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10.0);
            },
            reverse: false,
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              Message m = messages[index];
              if (m.user == 0) {
                return MessageRowWidget(
                  current: true,
                  message: m,
                );
              }
              return MessageRowWidget(
                current: false,
                message: m,
              );
            },
          ),
        ),
        BuildTextField()
      ],
    );
  }
}

