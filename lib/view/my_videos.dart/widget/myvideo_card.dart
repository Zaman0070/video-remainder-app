import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/constant/app_image.dart';
import 'package:reminder_app/constant/widget/catch_image.dart';

class MyVideoCard extends StatefulWidget {
  final String image;
  final String title;
  final String des;
  final DateTime time;
  final VoidCallback onTap;
  const MyVideoCard(
      {super.key,
      required this.image,
      required this.title,
      required this.onTap,
      required this.des,
      required this.time});

  @override
  State<MyVideoCard> createState() => _MyVideoCardState();
}

class _MyVideoCardState extends State<MyVideoCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
          margin: EdgeInsets.only(bottom: 20.h, left: 18, right: 18),
          height: 240.h,
          width: 1.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: grey3, width: 0.4),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xff26CBFF).withOpacity(0.25),
                const Color(0xff6980FD).withOpacity(0.25),
              ],
            ),
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.outer,
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 0),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 15.sp, color: black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.des,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: black.withOpacity(0.8),
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedRectangularNetworkImageWidget(
                    height: 115.h,
                    image: widget.image,
                    width: 1.sw,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      AppImage.clocks,
                      height: 18.h,
                      width: 18.w,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TimeAgoExample(
                        timestamp: widget.time
                            .subtract(const Duration(minutes: 1))),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class TimeAgoExample extends StatelessWidget {
  final DateTime timestamp;

  const TimeAgoExample({required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Text(formatTimeAgo(timestamp),
        style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w300,
            color: black.withOpacity(0.8)));
  }
}

String formatTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else {
    final formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(dateTime);
  }
}
