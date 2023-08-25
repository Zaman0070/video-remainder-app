import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/constant/widget/app_button.dart';
import 'package:reminder_app/constant/widget/common_textfield.dart';
import 'package:reminder_app/controller/image_controller.dart';
import 'package:reminder_app/view/upload_video/create_reminder.dart';
import 'package:reminder_app/view/upload_video/widgets/choose_card.dart';
import 'package:reminder_app/view/upload_video/widgets/gallery_view.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({super.key});

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  late String videoUrl = imagePickerController.videoUrl.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Add Video',
            style: TextStyle(color: appColor, fontSize: 17),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose your video',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ChooseCard(
                            onTap: () async {
                              videoUrl = await imagePickerController
                                  .pickVideo(ImageSource.camera);
                            },
                            image: AppImage.mic,
                            title: 'Record',
                          ),
                          ChooseCard(
                            onTap: () async {
                              videoUrl = await imagePickerController
                                  .pickVideo(ImageSource.gallery);
                            },
                            image: AppImage.gallery,
                            title: 'Gallery',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ]),
              ),
              const GalleryViews(),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title of the video',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: black,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 10.h,
                    ),
                    CommonTextField(
                        controller: titleController,
                        hintText: 'Enter title',
                        keyboardType: TextInputType.name),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text('Description(optional)',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: black,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 10.h,
                    ),
                    CommonTextField(
                        controller: descriptionController,
                        hintText: 'Enter description',
                        keyboardType: TextInputType.name),
                    SizedBox(
                      height: 25.h,
                    ),
                    AppButton(
                        text: 'Next',
                        onPressed: () {
                          Get.to(() => CreateRemainder(
                              thumbnailUrl:
                                  imagePickerController.videoThumbnailUrl,
                              videoUrl: videoUrl,
                              title: titleController.text,
                              description: descriptionController.text));
                        })
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ));
  }
}
