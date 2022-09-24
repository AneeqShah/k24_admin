import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/views/order_history/layout/widgets/history_tile.dart';

class OrderHistoryBody extends StatelessWidget {
  const OrderHistoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context,i){
        return HistoryTile();
      }),
    );
  }
}
