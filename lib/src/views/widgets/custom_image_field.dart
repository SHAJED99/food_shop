import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;

  const CustomNetworkImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) => SizedBox(
        width: width,
        height: height,
        child: FittedBox(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.no_photography, color: Theme.of(context).primaryColorLight),
        )),
      ),
    );
  }
}
