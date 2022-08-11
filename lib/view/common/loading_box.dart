import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingBox extends StatelessWidget {
  const LoadingBox({
    Key? key,
    required this.height,
    this.customWidth,
  }) : super(key: key);

  final double height;
  final double? customWidth;
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.grey,
          Colors.grey.shade100,
        ],
      ),
      child: Container(
        height: height,
        width: customWidth ?? MediaQuery.of(context).size.width * 0.75,
        color: Colors.grey,
      ),
    );
  }
}
