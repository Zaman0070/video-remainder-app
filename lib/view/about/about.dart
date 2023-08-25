import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:share_plus/share_plus.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: black,
            size: 18.h,
          ),
        ),
        title: Text(
          'About',
          style: TextStyle(
              color: appColor, fontSize: 17.sp, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Image.asset(
                AppImage.logo,
                height: 85.h,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '@Will',
              style: TextStyle(
                  color: black, fontSize: 42.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Auther',
                  style: TextStyle(fontSize: 14.sp, color: black),
                ),
                Text(
                  'WoodlawnElite',
                  style: TextStyle(fontSize: 14.sp, color: black),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                thickness: 0.6,
                color: grey3,
              ),
            ),
            InkWell(
              onTap: () {
                Share.share(
                    'https://play.google.com/store/apps/details?id=com.theAppForce.reminder');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Share',
                    style: TextStyle(fontSize: 14.sp, color: black),
                  ),
                  Text(
                    'com.theAppForce.reminder',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: black,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                thickness: 0.6,
                color: grey3,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Support',
                    style: TextStyle(fontSize: 14.sp, color: black),
                  ),
                  Row(
                    children: [
                      Text(
                        'Send Feedback',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: black,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
