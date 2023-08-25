import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/constant/app_image.dart';

class ChooseCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  const ChooseCard(
      {super.key,
      required this.image,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 90.h,
          width: 150.w,
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
              Image.asset(
                image,
                height: 40.h,
                width: 40.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16.sp, color: black, fontWeight: FontWeight.w400),
              )
            ],
          )),
    );
  }
}
