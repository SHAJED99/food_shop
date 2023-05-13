import 'dart:ui';
import 'package:flutter/material.dart';

class CustomBackgroundImage extends StatelessWidget {
  final Widget? child;
  const CustomBackgroundImage({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("lib/assets/images/login_page_1.jpg"), fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black45,
          child: child,
        ),
      ),
    );
  }
}
