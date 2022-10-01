

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

import '../../../../model/message.dart';
import '../widgets/build_texfield.dart';
import '../widgets/chat_message.dart';

class ChatViewBody extends StatefulWidget {
  final String CustomerID;

  const ChatViewBody({super.key, required this.CustomerID});
  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  String userID = FirebaseAuth.instance.currentUser!.uid;
  List<DocumentSnapshot> chat = [];
  ScrollController _controller = ScrollController();
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
        const SizedBox(height: 20,),
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
        BuildTextField()
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
}

