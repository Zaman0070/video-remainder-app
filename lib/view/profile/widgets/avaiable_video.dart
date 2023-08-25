import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/constant/app_image.dart';

class AvailableVideo extends StatelessWidget {
  final int? videoCount;
  const AvailableVideo({super.key, this.videoCount});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 88.h,
        width: 1.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: grey3, width: 0.4),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xff26CBFF).withOpacity(0.25),
              const Color(0xff6980FD).withOpacity(0.25),
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Available videos to be upload',
              style: TextStyle(
                  fontSize: 18.sp, color: black, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              '$videoCount Videos',
              style: TextStyle(
                  fontSize: 16.sp, color: black, fontWeight: FontWeight.w400),
            )
          ],
        ));
  }
}
