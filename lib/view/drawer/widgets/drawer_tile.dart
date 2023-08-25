import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/constant/app_image.dart';

class Drawertile extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const Drawertile(
      {super.key,
      required this.title,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(
              image,
              height: 22.h,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: appColor),
            ),
          ],
        ));
  }
}
