import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.imageUrl,
    this.borderRadius = BorderRadius.zero,
    this.width,
    this.height,
    this.margin = EdgeInsets.zero,
    this.fit,
    this.onTap,
  });
  final String imageUrl;
  final BorderRadiusGeometry borderRadius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry margin;
  final BoxFit? fit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: margin,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: imageUrl,
            fit: fit ?? BoxFit.cover,
            errorWidget: (context, url, error) {
              return const Icon(Icons.image_not_supported, color: Colors.white);
            },
            errorListener: (value) {},
          ),
        ),
      ),
    );
  }
}
