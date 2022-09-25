import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k24_admin/app/custom_loader.dart';
import 'package:k24_admin/presentation/elements/app_button.dart';
import 'package:k24_admin/presentation/elements/custom_text.dart';
import 'package:k24_admin/presentation/elements/custom_textfield.dart';

import '../../../../app/image_upload.dart';

class AddProductBody extends StatefulWidget {
  const AddProductBody({Key? key}) : super(key: key);

  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  TextEditingController pController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      isLoading: isLoading,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  _showPicker(context);
                },
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200),
                  child: file == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.grey,
                              size: 31,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: "Choose Image",
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            )
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            file!,
                            fit: BoxFit.fill,
                          )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomText(text: 'Title'),
              const SizedBox(
                height: 5,
              ),
              AuthTextField(
                hint: 'Product Title',
                controller: pController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(text: 'Range'),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                      child: AuthTextField(
                    hint: 'From',
                    keyBoardType: TextInputType.number,
                    controller: fromController,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: AuthTextField(
                    keyBoardType: TextInputType.number,
                    hint: 'To',
                    controller: toController,
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(text: 'Price'),
              const SizedBox(
                height: 5,
              ),
              AuthTextField(
                keyBoardType: TextInputType.number,
                hint: '€  10',
                controller: priceController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(text: 'Description'),
              const SizedBox(
                height: 5,
              ),
              AuthTextField(
                hint: 'Product Description here...',
                controller: descController,
                showDescription: true,
              ),
              const SizedBox(
                height: 10,
              ),
              AppButton(
                  onPressed: () {
                    if (file == null) {
                      Fluttertoast.showToast(msg: "Choose Image");
                    } else if (pController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Title can't be empty");
                    } else if (priceController.text.trim().isEmpty) {
                      Fluttertoast.showToast(msg: "Price can't be empty");
                    } else if (toController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Range can't be empty");
                    } else if (fromController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Range can't be empty");
                    } else if (descController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Description can't be empty");
                    } else {
                      _uploadProduct();
                    }
                  },
                  text: 'Add Product'),
            ],
          ),
        ),
      ),
    );
  }

  ImagePicker picker = ImagePicker();
  File? file;
  String imageUrl = "";

  @override
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text('Gallery'),
                      onTap: () {
                        getImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      getImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source, imageQuality: 30);
    if (pickedFile != null && pickedFile.path != null) {
      file = File(pickedFile.path);
      setState(() {
        print(imageUrl);
      });
    }
  }

  _uploadProduct() async {
    try {
      loadingTrue();
      String productID =
          FirebaseFirestore.instance.collection("products").doc().id;
      String image = await UploadFileServices().getUrl(context, file: file!);
      await FirebaseFirestore.instance
          .collection("products")
          .doc(productID)
          .set({
        "title": pController.text,
        "description": descController.text,
        "price": priceController.text,
        "toRange": toController.text,
        "fromRange": fromController.text,
        "image": image,
        "productID": productID,
      }).then((value) {
        Fluttertoast.showToast(msg: "Product Added");
        pController.clear();
        descController.clear();
        priceController.clear();
        toController.clear();
        fromController.clear();
        file = null;
        loadingFalse();
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
      loadingFalse();
    }
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
