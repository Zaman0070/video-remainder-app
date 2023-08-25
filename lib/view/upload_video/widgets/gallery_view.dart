import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_media_picker/gallery_media_picker.dart';
import 'package:get/get.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/controller/image_controller.dart';

class GalleryViews extends StatefulWidget {
  const GalleryViews({super.key});

  @override
  State<GalleryViews> createState() => _GalleryViewsState();
}

class _GalleryViewsState extends State<GalleryViews> {
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  Future<String> url = Future.value('');
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: GalleryMediaPicker(
          mediaPickerParams: MediaPickerParamsModel(
            appBarIconColor: white,
            onlyVideos: true,
            appBarHeight: 60,
            maxPickImages: 1,
            crossAxisCount: 3,
            childAspectRatio: 1,
            thumbnailQuality: 200,
            thumbnailBoxFix: BoxFit.cover,
            imageBackgroundColor: Colors.black,
            selectedCheckColor: Colors.black87,
            selectedBackgroundColor: Colors.black,
            selectedCheckBackgroundColor: Colors.white10,
            appBarLeadingWidget: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15, bottom: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// select multiple / single

                    const Spacer(),

                    /// share
                    GestureDetector(
                      onTap: () async {
                        imagePickerController
                            .uploadVideo(
                                imagePickerController.selectPathVideo.value)
                            .whenComplete(() {
                          imagePickerController.update();
                        });
                      },
                      child: Container(
                          height: 30,
                          width: 65,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue, width: 1.5),
                          ),
                          child: const Center(child: Text('upload'))),
                    )
                  ],
                ),
              ),
            ),
          ),
          pathList: (List<PickedAssetModel> path) {
            imagePickerController.selectPathVideo = File(path[0].path).obs;
            imagePickerController.update();
          },
        ));
  }
}
