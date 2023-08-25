import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/constant/app_image.dart';

class PinTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const PinTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: 40.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: appColor),
          gradient: LinearGradient(
            colors: [
              const Color(0xff26CBFF).withOpacity(0.3),
              const Color(0xff6980FD).withOpacity(0.3),
            ],
          )),
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        style: const TextStyle(color: black),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 17.w, top: 2),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 16.sp, color: black.withOpacity(0.5), letterSpacing: 1),
        ),
      ),
    );
  }
}
