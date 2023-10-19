import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/constant/widget/loadingWidget.dart';

class CachedRectangularNetworkImageWidget extends StatelessWidget {
  const CachedRectangularNetworkImageWidget(
      {super.key,
      required this.image,
      required this.width,
      required this.height,
      this.radius});

  final String image;
  final double width;
  final double height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(radius ?? 5.r),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => const Center(child: LoadingWidget()),
        errorWidget: (context, url, error) => Center(
            child: SizedBox(
                width: 20.w, height: 20.h, child: const Icon(Icons.error))),
      ),
    );
  }
}
