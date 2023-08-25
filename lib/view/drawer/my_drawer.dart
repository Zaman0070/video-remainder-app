import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/view/about/about.dart';
import 'package:reminder_app/view/drawer/widgets/drawer_appbar.dart';
import 'package:reminder_app/view/drawer/widgets/drawer_tile.dart';
import 'package:reminder_app/view/splash_screen/splash_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 1.sh,
        width: 0.79.sw,
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const DrawerAppBar(),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 0.6,
                color: appColor,
              ),
              const SizedBox(
                height: 25,
              ),
              Drawertile(
                  title: 'About',
                  image: AppImage.about,
                  onTap: () {
                    Get.to(() => const AboutPage());
                  }),
              const SizedBox(
                height: 25,
              ),
              Drawertile(
                  title: 'My Videos',
                  image: AppImage.video,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              const SizedBox(
                height: 25,
              ),
              Drawertile(
                  title: 'Logout',
                  image: AppImage.logout,
                  onTap: () async {
                    FirebaseAuth.instance.signOut().whenComplete(() {
                      Get.offAll(() => const SplashScreen());
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
