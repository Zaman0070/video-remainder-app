import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/view/my_videos.dart/my_videos.dart';
import 'package:reminder_app/view/profile/profile.dart';
import 'package:reminder_app/view/upload_video/upload_video.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CircleNavBar(
        circleColor: appColor,
        activeIcons: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              'assets/icons/videos.png',
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              'assets/icons/add.png',
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              'assets/icons/user.png',
              color: Colors.white,
            ),
          ),
        ],
        inactiveIcons: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Image.asset(
              'assets/icons/videos.png',
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Image.asset(
              'assets/icons/add.png',
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Image.asset(
              'assets/icons/user.png',
              color: Colors.white,
            ),
          ),
        ],
        color: appColor,
        height: 60,
        circleWidth: 50,
        activeIndex: tabIndex,
        onTap: (index) {
          tabIndex = index;
          pageController.jumpToPage(tabIndex);
        },
        // padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor: Colors.white24,
        elevation: 2,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (v) {
          tabIndex = v;
        },
        children: const [MyVideos(), UploadVideo(), ProfileScreen()],
      ),
    );
  }
}
