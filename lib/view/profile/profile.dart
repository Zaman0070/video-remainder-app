import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/constant/widget/app_button.dart';
import 'package:reminder_app/constant/widget/catch_image.dart';
import 'package:reminder_app/models/user.dart';
import 'package:reminder_app/view/drawer/my_drawer.dart';
import 'package:reminder_app/view/profile/widgets/avaiable_video.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: white,
                ),
              );
            }
            UserModel userModel = UserModel.fromMap(snapshot.data!.data()!);
            return Container(
              height: 1.sh,
              width: 1.sw,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(AppImage.prfile),
                fit: BoxFit.cover,
              )),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder(builder: (context) {
                            return InkWell(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Image.asset(
                                AppImage.menu,
                                height: 22.h,
                              ),
                            );
                          }),
                          Text(
                            'Profile',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: black),
                          ),
                          SizedBox(
                            width: 30.w,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 35.h,
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
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: CachedRectangularNetworkImageWidget(
                                  image: userModel.userImage!,
                                  height: 100,
                                  width: 100,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: Text(
                          userModel.userName!,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: black),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Center(
                        child: Text(
                          userModel.userEmail!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 15),
                        child: Divider(
                          thickness: 0.9.h,
                        ),
                      ),
                      Text(
                        userModel.userPhone!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Divider(
                          thickness: 0.9.h,
                        ),
                      ),
                      const AvailableVideo(
                        videoCount: 0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Divider(
                          thickness: 0.9.h,
                        ),
                      ),
                      AppButton(
                          text: 'Pay to upload a video', onPressed: () {}),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
