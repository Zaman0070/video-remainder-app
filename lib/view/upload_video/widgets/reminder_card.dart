import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/constant/app_image.dart';

class RemainderCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  const RemainderCard({super.key, required this.image, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 50.h,
            width: 50.h,
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
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                image,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(
              color: black, fontSize: 16.sp, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
