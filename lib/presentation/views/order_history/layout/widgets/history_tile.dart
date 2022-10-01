import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/Custom_image_container.dart';
import 'package:k24_admin/presentation/elements/custom_text.dart';

class HistoryTile extends StatelessWidget {
  final String image;
  final String userName;
  final String price;
  final String message;
  final String date;

  const HistoryTile(
      {super.key,
      required this.image,
      required this.userName,
      required this.price,
      required this.message,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomImageContainer(
          height: 50, wight: 50, radius: 500, image: image),
      title: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: userName),
            CustomText(text: '€ ${price}'),
          ],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          CustomText(
            text: message,
            fontWeight: FontWeight.w300,
            fontSize: 11,
          ),
          SizedBox(
            height: 5,
          ),
          CustomText(
            text: 'Date ${date}',
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          Divider(),
        ],
      ),
    );
  }
}
