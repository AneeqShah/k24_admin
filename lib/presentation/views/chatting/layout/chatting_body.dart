import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

import '../../../../model/message.dart';
import '../widgets/build_texfield.dart';
import '../widgets/chat_message.dart';

class ChatViewBody extends StatefulWidget {
  final String CustomerID;
  final bool fromChat;

  const ChatViewBody(
      {super.key, required this.CustomerID, required this.fromChat});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  String userID = FirebaseAuth.instance.currentUser!.uid;
  List<DocumentSnapshot> chat = [];
  ScrollController _controller = ScrollController();
  TextEditingController _message = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _getchat();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.separated(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10.0);
            },
            reverse: false,
            itemCount: chat.length,
            itemBuilder: (BuildContext context, int index) {
              if (chat[index]["userID"] == userID) {
                return MessageRowWidget(
                  current: true,
                  message: chat[index]["question"],
                );
              }
              return MessageRowWidget(
                current: false,
                message: chat[index]["question"],
              );
            },
          ),
        ),
        widget.fromChat
            ? BuildTextField(
                controller: _message,
                onSend: () {
                  _sendChat();
                },
              )
            : Container()
      ],
    );
  }

  _getchat() async {
    await FirebaseFirestore.instance
        .collection("questions")
        .doc(widget.CustomerID)
        .collection("chat")
        .orderBy("time", descending: false)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      chat.clear();
      snapshot.docs.forEach((element) {
        chat.add(element);
        setState(() {});
      });
    });
  }

  _sendChat() async {
    FirebaseFirestore.instance
        .collection("chatList")
        .doc(userID)
        .collection("users")
        .doc(widget.CustomerID)
        .set({
      "customerID": widget.CustomerID,
      "isAnswered": true,
      "time": DateTime.now().millisecondsSinceEpoch
    }, SetOptions(merge: true)).then((value) async {
      String chatID = FirebaseFirestore.instance
          .collection("chat")
          .doc()
          .collection("messages")
          .doc()
          .id;
      await FirebaseFirestore.instance
          .collection("questions")
          .doc(widget.CustomerID)
          .collection("chat")
          .doc(chatID)
          .set({
        "userID": userID,
        "question": _message.text,
        "orderID": "",
        "chatID": chatID,
        "time": DateTime.now().millisecondsSinceEpoch,
      });
    }).then((value){
      _message.clear();
    });
  }
}
