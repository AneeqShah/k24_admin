import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:k24_admin/app/custom_loader.dart';
import 'package:k24_admin/presentation/views/order_history/layout/widgets/history_tile.dart';

class OrderHistoryBody extends StatefulWidget {
  const OrderHistoryBody({Key? key}) : super(key: key);

  @override
  State<OrderHistoryBody> createState() => _OrderHistoryBodyState();
}

class _OrderHistoryBodyState extends State<OrderHistoryBody> {
  List<DocumentSnapshot> allHistory = [];
  List<DocumentSnapshot> allUser = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      isLoading: isLoading,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: allHistory.length,
            itemBuilder: (context, i) {
              DateTime time = DateTime.fromMillisecondsSinceEpoch(
                  allHistory[i]["orderTime"]);
              var uploadTime = Jiffy(time).yMMMd;
              return HistoryTile(
                  image: allUser[i]["image"],
                  userName: allUser[i]["name"],
                  price: allHistory[i]["price"],
                  message: "",
                  date: uploadTime);
            }),
      ),
    );
  }

  _getHistory() async {
    await FirebaseFirestore.instance
        .collection("order")
        .orderBy("orderTime", descending: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) async {
      allHistory.clear();
      snapshot.docs.forEach((element) async {
        allHistory.add(element);
        var a = await FirebaseFirestore.instance
            .collection("Users")
            .doc(element["customerID"])
            .get();
        allUser.add(a);
        setState(() {});
      });
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
