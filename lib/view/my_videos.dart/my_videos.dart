import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/view/drawer/my_drawer.dart';
import 'package:reminder_app/view/my_videos.dart/widget/myvideo_widget.dart';

class MyVideos extends StatefulWidget {
  const MyVideos({super.key});

  @override
  State<MyVideos> createState() => _MyVideosState();
}

class _MyVideosState extends State<MyVideos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MyDrawer(),
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Image.asset(
                        AppImage.menu,
                        height: 22.h,
                      ),
                    );
                  }),
                  Text(
                    'My Videos',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: black),
                  ),
                  SizedBox(
                    width: 30.w,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const MyVideoWidget(),
          ],
        )));
  }
}
