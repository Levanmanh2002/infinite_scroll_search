import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BoxShape? shape;
  final double? radius;
  final ImageWidgetBuilder? imageBuilder;

  const CustomImageWidget({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.shape,
    this.radius,
    this.imageBuilder,
  });

  ImageWidgetBuilder get _defaultImageBuilder => (
        BuildContext context,
        ImageProvider<Object> imageProvider,
      ) {
        return DecoratedBox(
          decoration: BoxDecoration(
            shape: shape ?? BoxShape.rectangle,
            borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(radius ?? 0),
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
          ),
        );
      };

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: width,
      fit: fit,
      imageBuilder: imageBuilder ?? _defaultImageBuilder,
      placeholder: (context, url) => const Icon(Icons.image),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
