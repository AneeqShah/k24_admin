import 'package:flutter/material.dart';

import '../../../elements/Custom_image_container.dart';
import '../../../elements/custom_text.dart';

class ProductTile extends StatelessWidget {
  String title;
  String min;
  String max;
  String image;
  String price;

  ProductTile(
      {required this.title,
      required this.min,
      required this.max,
      required this.price,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomImageContainer(
                height: 80, wight: 80, radius: 6, image: image),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: CustomText(
                      text: title,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: "Range: ${min} to ${max} words",
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            CustomText(text: '€ ${price}')
          ],
        ),
      ),
    );
  }
}
