import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/constant/widget/app_button.dart';
import 'package:reminder_app/constant/widget/loading.dart';
import 'package:reminder_app/services/auth_services/auth_services.dart';
import 'package:reminder_app/view/auth/widgets/pin_tf.dart';

class PinScreen extends StatefulWidget {
  final EmailOTP myauth;
  final String email;
  const PinScreen({super.key, required this.email, required this.myauth});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final EmailOTP myauth = EmailOTP();
  var pin1 = TextEditingController();
  var pin2 = TextEditingController();
  var pin3 = TextEditingController();
  var pin4 = TextEditingController();
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.login),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "We've sent a pin to ",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: black),
                ),
                Text(
                  widget.email,
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: appColor),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Check your spam folder if you don’t\nreceive it.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.sp, color: black),
            ),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PinTextField(
                        controller: pin1,
                        hintText: '',
                      ),
                      PinTextField(
                        controller: pin2,
                        hintText: '',
                      ),
                      PinTextField(
                        controller: pin3,
                        hintText: '',
                      ),
                      PinTextField(
                        controller: pin4,
                        hintText: '',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120.h,
                  ),
                  AppButton(
                      text: 'Sign-in',
                      onPressed: () async {
                        SmartDialog.showLoading(
                          animationBuilder:
                              (controller, child, animationParam) {
                            return Loading(
                              text: 'Please wait...',
                            );
                          },
                        );
                        if (await widget.myauth.verifyOTP(
                                otp: pin1.text +
                                    pin2.text +
                                    pin3.text +
                                    pin4.text) ==
                            true) {
                          // ignore: use_build_context_synchronously
                          await authServices.userRegister(
                              email: widget.email,
                              context: context,
                              password: '123456');
                          SmartDialog.dismiss();
                          Get.snackbar('Success !', 'OTP Verified Successfully',
                              backgroundColor: white);
                        } else {
                          SmartDialog.dismiss();
                          Get.snackbar('Error !', 'Invalid OTP',
                              backgroundColor: Colors.red);
                        }
                      }),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: Text(
                      'I need another pin',
                      style: TextStyle(
                          color: appColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
          ],
        ),
      ),
    );
  }
}
