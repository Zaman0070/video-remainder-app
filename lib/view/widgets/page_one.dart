import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/constant/widget/app_button.dart';
import 'package:reminder_app/view/auth/login_screen.dart';

class PageOne extends StatelessWidget {
  final VoidCallback onPressed;
  const PageOne({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImage.onbording1),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Get.offAll(() => const LoginScreen());
              },
              child: Text('Skip',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: black,
                      fontWeight: FontWeight.w500)),
            ),
            const Spacer(),
            Center(
              child: Text(
                'The huge base of \nusers',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26.sp, color: black, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            AppButton(
              text: 'Next',
              onPressed: onPressed,
            ),
            const SizedBox(
              height: 65,
            ),
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Container(
                      height: 10.h,
                      width: index == 0 ? 18.h : 10.h,
                      decoration: BoxDecoration(
                        color: index == 0 ? appColor : grey3,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
