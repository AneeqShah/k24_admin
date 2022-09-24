import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/custom_app_bar.dart';
import 'package:k24_admin/presentation/views/order_history/layout/order_history_body.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Order History',showIcon: true),
      body: OrderHistoryBody(),
    );
  }
}
