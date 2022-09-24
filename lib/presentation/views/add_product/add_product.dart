import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/custom_app_bar.dart';
import 'package:k24_admin/presentation/views/add_product/layout/add_product_body.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar('Add Product',showIcon: true),
      body: AddProductBody(),
    );
  }
}
