import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/custom_text.dart';

class AnsweredTile extends StatelessWidget {
  const AnsweredTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 35,
        backgroundImage: AssetImage('assets/images/dp.png'),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: 'Luna'),
            CustomText(text: 'Date 21/12/2022',fontSize: 12,fontWeight: FontWeight.w500,),
          ],
        ),
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          CustomText(
            text: 'Lorem Ipsum is simply dummy text of the printing'
                'and typesetting industry. Lorem Ipsum ',
            fontWeight: FontWeight.w300,
            fontSize: 11,
          ),

          Divider(),
        ],
      ),
    );
  }
}
