import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/view/auth/login_screen.dart';
import 'package:reminder_app/view/widgets/page_one.dart';
import 'package:reminder_app/view/widgets/page_three.dart';
import 'package:reminder_app/view/widgets/page_two.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
        children: [
          PageOne(
            onPressed: () {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
          ),
          PageTwo(
            onPressed: () {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            },
          ),
          PageThree(onPressed: () {
            Get.offAll(() => const LoginScreen());
          })
        ],
      ),
    );
  }
}
