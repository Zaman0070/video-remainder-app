import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/models/video.dart';
import 'package:reminder_app/view/my_videos.dart/show_video.dart';
import 'package:reminder_app/view/my_videos.dart/widget/myvideo_card.dart';

class MyVideoWidget extends StatelessWidget {
  const MyVideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('videos')
                  .where('uid',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: white,
                    ),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 150.h,
                      ),
                      Image.asset(
                        'assets/images/empty.png',
                        height: 170.h,
                        width: 170.w,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'There are no item yet.',
                        style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w500,
                            color: appColor.withOpacity(0.3)),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                    padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      VideoModel videoModel =
                          VideoModel.fromMap(snapshot.data!.docs[index].data());
                      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                          int.parse(videoModel.time!));
                      return MyVideoCard(
                          time: dateTime,
                          des: videoModel.description!,
                          image: videoModel.videoThumbnailUrl!,
                          title: videoModel.title!,
                          onTap: () {
                            Get.to(() => ShowVideo(
                                  videoUrl: videoModel.videoUrl!,
                                ));
                          });
                    });
              })
        ],
      ),
    ));
  }
}
