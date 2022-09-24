import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/app_button.dart';
import 'package:k24_admin/presentation/elements/custom_text.dart';
import 'package:k24_admin/presentation/elements/custom_textfield.dart';

class AddProductBody extends StatelessWidget {
  const AddProductBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController pController = TextEditingController();
    TextEditingController fromController = TextEditingController();
    TextEditingController toController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController descController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: 'Title'),
          SizedBox(height: 5,),
          AuthTextField(hint: 'Product Title', controller: pController),
          SizedBox(height: 10,),
          CustomText(text: 'Range'),
          SizedBox(height: 5,),
          Row(
            children: [
              Expanded(child: AuthTextField(hint: 'From', controller: fromController,)),
              SizedBox(width: 10,),
              Expanded(child: AuthTextField(hint: 'To', controller: toController,)),
            ],
          ),
          SizedBox(height: 10,),
          CustomText(text: 'Price'),
          SizedBox(height: 5,),
          AuthTextField(hint: '€  10', controller: priceController),
          SizedBox(height: 10,),
          CustomText(text: 'Description'),
          SizedBox(height: 5,),
          AuthTextField(hint: 'Product Description here...', controller: descController,
          showDescription: true,
          ),
          SizedBox(height: 10,),
          AppButton(onPressed: (){}, text: 'Add Product'),
        ],
      ),
    );
  }
}
