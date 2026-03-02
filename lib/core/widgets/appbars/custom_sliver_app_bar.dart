import 'package:flutter/material.dart';
import '../buttons/app_back_button.dart';
import '../images/app_network_image.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final String imagePath;

  const CustomSliverAppBar({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      leading: const AppBackButton(),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          title,
          style: const TextStyle(
            shadows: [Shadow(color: Colors.black, blurRadius: 4)],
          ),
        ),
        background: AppNetworkImage(imagePath: imagePath, fit: BoxFit.cover),
      ),
    );
  }
}
