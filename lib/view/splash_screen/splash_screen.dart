import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/view/main_menu/main_menu.dart';
import 'package:reminder_app/view/splash_screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 4),
      () => Get.offAll(() => FirebaseAuth.instance.currentUser == null
          ? const OnBoardingScreen()
          : const MainMenu()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.splash),
            fit: BoxFit.cover,
          ),
        ));
  }
}
