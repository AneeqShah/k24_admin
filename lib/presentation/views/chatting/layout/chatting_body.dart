import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k24_admin/app/custom_loader.dart';
import 'package:k24_admin/app/image_upload.dart';
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
  bool isLoading = false;

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
    return CustomLoader(
      isLoading: isLoading,
      child: Column(
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
                    message: chat[index]["question"], isImage: chat[index]['isImage'],
                  );
                }
                return MessageRowWidget(
                  current: false,
                  message: chat[index]["question"], isImage: chat[index]['isImage'],
                );
              },
            ),
          ),
          widget.fromChat
              ? BuildTextField(
                  controller: _message,
                  onSend: () {
                    if (_message.text.trim() != "") {
                      _sendChat(false);
                    } else {
                      Fluttertoast.showToast(msg: "Message can't be empty");
                    }
                  },
                  onImage: () {
                    getImage(ImageSource.gallery);
                  },
                )
              : Container()
        ],
      ),
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

  _sendChat(bool isImage) async {
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
        "question": isImage ? imageUrl : _message.text,
        "orderID": "",
        "chatID": chatID,
        "isImage": isImage,
        "time": DateTime.now().millisecondsSinceEpoch,
      });
    }).then((value) {
      _message.clear();
    });
  }

  ImagePicker picker = ImagePicker();
  File? file;
  String imageUrl = "";

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source, imageQuality: 30);
    if (pickedFile != null && pickedFile.path != null) {
      file = File(pickedFile.path);
      try {
        loadingTrue();
        imageUrl = await UploadFileServices().getUrl(context, file: file!);
        _sendChat(true);
        loadingFalse();
      } on FirebaseException catch (e) {
        loadingFalse();
        Fluttertoast.showToast(msg: e.message!);
      }
    }
  }

  loadingTrue() {
    isLoading = true;
    setState(() {});
  }

  loadingFalse() {
    isLoading = false;
    setState(() {});
  }
}
