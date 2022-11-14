import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k24_admin/navigation_helper/navigation_helper.dart';
import 'package:k24_admin/presentation/elements/Custom_image_container.dart';
import 'package:k24_admin/presentation/views/bottom_nav_bar/bottom_nav_bar.dart';
import '../../../app/custom_loader.dart';
import '../../../app/image_upload.dart';
import '../../../config/front_end_config.dart';
import '../../elements/app_button.dart';
import '../../elements/custom_app_bar.dart';
import '../../elements/custom_text.dart';
import '../../elements/custom_textfield.dart';

class EditProfile extends StatefulWidget {
  final String image;
  final String productTitle;
  final String maxRange;
  final String minRange;
  final String price;
  final String description;
  final String productID;

  const EditProfile(
      {super.key,
      required this.image,
      required this.productTitle,
      required this.maxRange,
      required this.minRange,
      required this.price,
      required this.description,
      required this.productID});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController pController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    pController.text = widget.productTitle;
    minController.text = widget.minRange;
    maxController.text = widget.maxRange;
    priceController.text = widget.price;
    descController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Edit Product", showIcon: true),
      backgroundColor: Colors.white,
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
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
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200),
                  child: file == null
                      ? CustomImageContainer(
                          height: 200,
                          wight: 200,
                          radius: 8,
                          image: widget.image)
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
                    hint: 'Minimum',
                    keyBoardType: TextInputType.number,
                    controller: minController,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: AuthTextField(
                    keyBoardType: TextInputType.number,
                    hint: 'Maximum',
                    controller: maxController,
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
                    if (pController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Title can't be empty");
                    } else if (priceController.text.trim().isEmpty) {
                      Fluttertoast.showToast(msg: "Price can't be empty");
                    } else if (minController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Range can't be empty");
                    } else if (maxController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Range can't be empty");
                    } else if (descController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Description can't be empty");
                    } else {
                      _uploadProduct();
                    }
                  },
                  text: 'Edit Product'),
              SizedBox(
                height: 10,
              ),
              AppButton(
                onPressed: () async {
                  await _deleteProduct();
                },
                text: "Delete Product",
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }

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

  ImagePicker picker = ImagePicker();
  File? file;

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source, imageQuality: 30);
    if (pickedFile != null && pickedFile.path != null) {
      file = File(pickedFile.path);
      setState(() {});
    }
  }

  _deleteProduct() async {
    loadingTrue();
    await FirebaseFirestore.instance
        .collection("products")
        .doc(widget.productID)
        .delete()
        .then((value) {
      loadingFalse();
      Navigator.pop(context);
    });
    loadingFalse();
  }

  _uploadProduct() async {
    try {
      loadingTrue();
      String image = "";
      if (file != null) {
        image = await UploadFileServices().getUrl(context, file: file!);
      }
      await FirebaseFirestore.instance
          .collection("products")
          .doc(widget.productID)
          .set({
        "title": pController.text,
        "description": descController.text,
        "price": priceController.text,
        "min": minController.text,
        "max": maxController.text,
        "image": image != "" ? image : widget.image,
      }, SetOptions(merge: true)).then((value) {
        Fluttertoast.showToast(msg: "Product Edit");
        file = null;
        NavigationHelper.pushReplacement(context, const BottomNavBody());
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
