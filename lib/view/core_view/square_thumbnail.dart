import 'package:flutter/material.dart';

class SquareThumbnail extends StatelessWidget {
  const SquareThumbnail({super.key, required this.url, required this.width});

  final String url;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(url),
    );
  }
}
