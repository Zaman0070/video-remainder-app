import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/constant/widget/app_button.dart';
import 'package:reminder_app/constant/widget/common_textfield.dart';
import 'package:reminder_app/constant/widget/loading.dart';
import 'package:reminder_app/view/auth/pin_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  bool isCheck = false;

  EmailOTP myauth = EmailOTP();

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
            Text(
              'Welcome',
              style: TextStyle(
                  fontSize: 45.sp, fontWeight: FontWeight.bold, color: black),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Please sign-in with your email',
              style: TextStyle(fontSize: 17.sp, color: black),
            ),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    hintText: 'Email Address',
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Text('Term of Service',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16.sp,
                          color: appColor,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 18.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isCheck = !isCheck;
                          });
                        },
                        child: Container(
                          height: 16.h,
                          width: 16.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(color: appColor, width: 1.5),
                          ),
                          child: Icon(
                            Icons.check,
                            color:
                                isCheck == true ? appColor : Colors.transparent,
                            size: 12.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text('I agree to the term & condition',
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: black,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  AppButton(
                      text: 'Continue',
                      onPressed: () async {
                        if (isCheck == true &&
                            emailController.text.isNotEmpty) {
                          SmartDialog.showLoading(
                            animationBuilder:
                                (controller, child, animationParam) {
                              return Loading(
                                text: 'Please wait...',
                              );
                            },
                          );
                          await myauth.setConfig(
                              appEmail: "contact@hdevcoder.com",
                              appName: "Reminder App",
                              userEmail: emailController.text,
                              otpLength: 4,
                              otpType: OTPType.digitsOnly);
                          if (await myauth.sendOTP() == true) {
                            SmartDialog.dismiss();
                            Get.to(() => PinScreen(
                                  myauth: myauth,
                                  email: emailController.text,
                                ));
                            Get.snackbar('OTP !', 'OTP sent to your email',
                                backgroundColor: white);
                          } else {
                            SmartDialog.dismiss();
                            Get.snackbar('Error !', 'Something went wrong',
                                backgroundColor: Colors.red);
                          }
                        } else {
                          Get.snackbar(
                              'Error !', 'Please check the term & condition',
                              backgroundColor: Colors.red);
                        }
                      }),
                  SizedBox(
                    height: 35.h,
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
