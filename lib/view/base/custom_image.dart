import 'package:cached_network_image/cached_network_image.dart';
import 'package:cfit/util/images.dart';
import 'package:flutter/cupertino.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFit fit;
  const CustomImage(
      {required this.image,
      this.height = 200,
      this.width = 200,
      this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) =>
          Image.asset(Images.profile, height: height, width: width, fit: fit),
      errorWidget: (context, url, error) =>
          Image.asset(Images.profile, height: height, width: width, fit: fit),
    );
  }
}
