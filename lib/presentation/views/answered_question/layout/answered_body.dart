import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:k24_admin/app/custom_loader.dart';

import '../../../../navigation_helper/navigation_helper.dart';
import '../../chat_list/layout/widgets/chat_list_tile.dart';
import '../../chatting/chatting_view.dart';

class AnsweredBody extends StatefulWidget {
  const AnsweredBody({Key? key}) : super(key: key);

  @override
  State<AnsweredBody> createState() => _AnsweredBodyState();
}

class _AnsweredBodyState extends State<AnsweredBody> {
  List<DocumentSnapshot> allUser = [];
  List allTime = [];
  List products = [];
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
                  DateTime time =
                      DateTime.fromMillisecondsSinceEpoch(allTime[i]);
                  var uploadTime = Jiffy(time).yMMMdjm;
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
        .where("isAnswered", isEqualTo: true)
        .orderBy("time", descending: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      allUser.clear();
      allTime.clear();
      products.clear();
      snapshot.docs.forEach((element) async {
        allTime.add(element["time"]);
        products.add(element["productID"]);
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
