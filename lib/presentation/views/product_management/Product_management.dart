import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/views/edit_product/Edit_Product.dart';
import 'package:k24_admin/presentation/views/product_management/widget/product_tile.dart';

import '../../../navigation_helper/navigation_helper.dart';
import '../../elements/custom_app_bar.dart';

class ProductManagement extends StatefulWidget {
  const ProductManagement({Key? key}) : super(key: key);

  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  List<DocumentSnapshot> allProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Profile", showIcon: true),
      backgroundColor: Colors.white,
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: allProducts.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                NavigationHelper.pushRoute(
                    context,
                    EditProfile(
                        image: allProducts[i]["image"],
                        productTitle: allProducts[i]["title"],
                        maxRange: allProducts[i]["max"],
                        minRange: allProducts[i]["min"],
                        price: allProducts[i]["price"],
                        description: allProducts[i]["description"],
                        productID: allProducts[i]["productID"]));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: ProductTile(
                  image: allProducts[i]["image"],
                  price: allProducts[i]["price"],
                  title: allProducts[i]["title"],
                  min: allProducts[i]["min"],
                  max: allProducts[i]["max"],
                ),
              ),
            );
          }),
    );
  }

  _getProducts() async {
    await FirebaseFirestore.instance
        .collection("products")
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        allProducts.add(element);
      });
      setState(() {});
    });
  }
}
