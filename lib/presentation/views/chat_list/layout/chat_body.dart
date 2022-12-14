import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:k24_admin/app/custom_loader.dart';
import 'package:k24_admin/presentation/views/chat_list/layout/widgets/chat_list_tile.dart';
import 'package:k24_admin/presentation/views/chatting/chatting_view.dart';

import '../../../../navigation_helper/navigation_helper.dart';

class ChatListBody extends StatefulWidget {
  const ChatListBody({Key? key}) : super(key: key);

  @override
  State<ChatListBody> createState() => _ChatListBodyState();
}

class _ChatListBodyState extends State<ChatListBody> {
  List<DocumentSnapshot> allUser = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _getchat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      isLoading: isLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: allUser.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        NavigationHelper.pushRoute(
                            context,
                            ChatView(
                              customerID: allUser[i]["uid"],
                              name: allUser[i]["name"],
                              fromChat: true,
                            ));
                      },
                      child: ChatListTile(
                        title: allUser[i]["name"],
                        image: allUser[i]["image"],
                      ),
                    ),
                  );
                })),
      ),
    );
  }

  _getchat() async {
    loadingTrue();
    await FirebaseFirestore.instance
        .collection("chatList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("users")
        .where("isAnswered", isEqualTo: false)
        .orderBy("time", descending: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      allUser.clear();
      setState(() {});
      snapshot.docs.forEach((element) async {
        var a = await FirebaseFirestore.instance
            .collection("Users")
            .doc(element["customerID"])
            .get();
        allUser.add(a);
        setState(() {});
      });
      loadingFalse();
    });
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
