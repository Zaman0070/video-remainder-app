import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/constant/widget/app_button.dart';
import 'package:reminder_app/constant/widget/common_textfield.dart';
import 'package:reminder_app/controller/image_controller.dart';
import 'package:reminder_app/models/user.dart';
import 'package:reminder_app/services/firebase_services/firebase_services.dart';

// ignore: must_be_immutable
class CreateProfile extends StatefulWidget {
  final String email;
  CreateProfile({super.key, required this.email});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var descriptionController = TextEditingController();

  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  FirebaseServices firebaseServices = FirebaseServices();

  List<String> image = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Create Profile',
          style: TextStyle(color: appColor, fontSize: 16.sp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 8.h,
            ),
            Center(
              child: Container(
                height: 100.h,
                width: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  image: const DecorationImage(
                    image: AssetImage(AppImage.pframe),
                    fit: BoxFit.cover,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(BottomWidget(
                      camera: () async {
                        image = await imagePickerController
                            .pickImage(ImageSource.camera)
                            .whenComplete(() {
                          Get.back();
                          setState(() {});
                        });
                      },
                      gallery: () async {
                        image = await imagePickerController
                            .pickImage(ImageSource.gallery)
                            .whenComplete(() {
                          Get.back();
                          setState(() {});
                        });
                      },
                    ));
                  },
                  child: imagePickerController.pickedFile == null
                      ? Icon(
                          Icons.camera_alt,
                          color: appColor,
                          size: 32.h,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: Image.file(
                              File(
                                imagePickerController.pickedFile!.path,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Name',
              style: TextStyle(fontSize: 15.sp, color: black),
            ),
            SizedBox(
              height: 10.h,
            ),
            CommonTextField(
              controller: nameController,
              hintText: 'Enter Name',
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'Phone',
              style: TextStyle(fontSize: 15.sp, color: black),
            ),
            SizedBox(
              height: 10.h,
            ),
            CommonTextField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                hintText: 'Enter Phone'),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'Description',
              style: TextStyle(fontSize: 15.sp, color: black),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 135.h,
              width: 1.sw,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: appColor),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xff26CBFF).withOpacity(0.25),
                      const Color(0xff6980FD).withOpacity(0.25),
                    ],
                  )),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 1.5),
                child: TextFormField(
                  style: TextStyle(
                      fontSize: 16.sp, color: black, letterSpacing: 1),
                  maxLines: 4,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'type here...',
                    hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: black.withOpacity(0.5),
                        letterSpacing: 1),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 45.h,
            ),
            AppButton(
                text: 'Complete Profile',
                onPressed: () async {
                  if (nameController.text.trim().isNotEmpty &&
                      phoneController.text.trim().isNotEmpty) {
                    image.isNotEmpty
                        ? await firebaseServices.updateProfile(UserModel(
                            userEmail: widget.email,
                            userImage: image[0],
                            userName: nameController.text,
                            userPhone: phoneController.text,
                            userDescription: descriptionController.text,
                            uid: FirebaseAuth.instance.currentUser!.uid,
                          ))
                        : Get.snackbar('Error !', 'Please select image');
                  } else {
                    Get.snackbar('Error !', 'Please fill all the fields');
                  }
                }),
            SizedBox(
              height: 25.h,
            ),
          ]),
        ),
      ),
    );
  }
}

class BottomWidget extends StatelessWidget {
  final VoidCallback camera;
  final VoidCallback gallery;
  const BottomWidget({super.key, required this.camera, required this.gallery});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r), color: white),
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Text(
            'Choose Image',
            style: TextStyle(fontSize: 16.sp, color: black),
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: camera,
                child: Container(
                  height: 50.h,
                  width: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: appColor, width: 1.5),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: appColor,
                    size: 32.h,
                  ),
                ),
              ),
              InkWell(
                onTap: gallery,
                child: Container(
                  height: 50.h,
                  width: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: appColor, width: 1.5),
                  ),
                  child: Icon(
                    Icons.photo,
                    color: appColor,
                    size: 32.h,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
