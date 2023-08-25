import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/constant/app_image.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  const CommonTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1.5),
        child: TextFormField(
          style: const TextStyle(color: black),
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: 16.sp,
                color: black.withOpacity(0.5),
                letterSpacing: 1),
          ),
        ),
      ),
    );
  }
}
