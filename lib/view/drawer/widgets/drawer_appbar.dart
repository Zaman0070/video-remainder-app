import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/constant/widget/catch_image.dart';
import 'package:reminder_app/models/user.dart';

class DrawerAppBar extends StatelessWidget {
  const DrawerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 65.h,
                width: 65.h,
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
                        height: 65,
                        width: 65,
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                userModel.userEmail!,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    color: black),
              ),
            ],
          );
        });
  }
}
