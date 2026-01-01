import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(
    this.imageUrl, {
    super.key,
    this.borderRadius = BorderRadius.zero,
    this.width,
    this.height,
    this.margin = EdgeInsets.zero,
    this.fit,
  });
  final String imageUrl;
  final BorderRadiusGeometry borderRadius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry margin;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          width: width,
          height: height,
          imageUrl: imageUrl,
          fit: fit ?? BoxFit.cover,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          errorListener: (value) {},
        ),
      ),
    );
  }
}
