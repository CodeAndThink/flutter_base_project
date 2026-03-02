import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../network/api_constants.dart';

class AppNetworkImage extends StatelessWidget {
  final String imagePath;
  final BoxFit fit;

  const AppNetworkImage({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath.isEmpty) {
      return const Center(child: Icon(Icons.error));
    }

    return CachedNetworkImage(
      imageUrl: '${ApiConstants.imageBaseUrl}$imagePath',
      fit: fit,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
