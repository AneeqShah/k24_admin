import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:k24_admin/config/front_end_config.dart';
import 'package:k24_admin/navigation_helper/navigation_helper.dart';
import 'package:k24_admin/presentation/elements/custom_text.dart';
import 'package:k24_admin/presentation/views/update_profile/update_profile.dart';

import '../../../../model/message.dart';
import '../widgets/build_texfield.dart';
import '../widgets/chat_message.dart';

class ChatViewBody extends StatefulWidget {
  final String CustomerID;
  final bool fromChat;
  final String name;

  const ChatViewBody(
      {super.key,
      required this.CustomerID,
      required this.fromChat,
      required this.name});

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
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "View ${widget.name} profile",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                IconButton(
                    onPressed: () {
                      NavigationHelper.pushRoute(context,
                          UpdateProfile(customerID: widget.CustomerID));
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: FrontEndConfigs.kPrimaryColor,
                    ))
              ],
            ),
          ),
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
    }).then((value) {
      _message.clear();
    });
  }
}
