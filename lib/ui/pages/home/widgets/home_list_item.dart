import 'package:flutter/material.dart';
import 'package:flutter_base_project/data/models/entities/movie.dart';
import 'package:flutter_base_project/ui/widgets/images/app_network_image.dart';

class HomeListItem extends StatelessWidget {
  final VoidCallback onTap;
  final Movie movie;
  const HomeListItem({super.key, required this.onTap, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: AppNetworkImage(
                imagePath: movie.posterPath ?? '',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title ?? 'Unknown',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
