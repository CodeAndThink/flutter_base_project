import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/constants/app_colors.dart';

class AppCacheImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final int? cacheWidth;
  final int? cacheHeight;
  final BoxFit fit;
  final FilterQuality filterQuality;

  const AppCacheImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.cacheWidth,
    this.cacheHeight,
    this.fit = BoxFit.cover,
    this.filterQuality = FilterQuality.low,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath,
      width: width,
      height: height,
      memCacheWidth: cacheWidth,
      memCacheHeight: cacheHeight,
      fit: fit,
      filterQuality: filterQuality,
      errorWidget: (context, url, error) => const Center(
        child: Icon(
          Icons.broken_image,
          size: 50,
          color: AppColors.placeholderText,
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(
          value: downloadProgress.progress,
          color: AppColors.placeholderText,
        ),
      ),
    );
  }
}
