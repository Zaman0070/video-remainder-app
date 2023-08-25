import 'dart:async';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/constant/app_image.dart';

class ShowVideo extends StatefulWidget {
  final String videoUrl;

  const ShowVideo({required this.videoUrl, Key? key}) : super(key: key);

  @override
  State<ShowVideo> createState() => _ShowVideoState();
}

class _ShowVideoState extends State<ShowVideo> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  late String videoUrl = widget.videoUrl;
  bool isPlaying = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(const Duration(seconds: 120), (Timer t) => AdHelper.showRewardedAd(onComplete: (){}));
    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((value) => setState(() {
            isPlaying = true;
          }));
    _customVideoPlayerController = CustomVideoPlayerController(
      customVideoPlayerSettings: const CustomVideoPlayerSettings(
          customVideoPlayerProgressBarSettings:
              CustomVideoPlayerProgressBarSettings(
        showProgressBar: true,
      )),
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isPlaying
            ? CustomVideoPlayer(
                customVideoPlayerController: _customVideoPlayerController)
            : const CircularProgressIndicator(
                color: appColor,
              ),
      ),
    );
  }
}
