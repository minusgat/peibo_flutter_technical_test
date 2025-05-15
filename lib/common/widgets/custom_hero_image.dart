import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomHeroImage extends StatelessWidget {
  const CustomHeroImage({
    super.key,
    required this.size,
    required this.imageUrl,
    required this.placeholder,
  });

  final double size;
  final String imageUrl;
  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageUrl,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: size,
        height: size,

        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return placeholder;
        },
      ),
    );
  }
}
