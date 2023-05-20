import 'package:flutter/material.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';

class CustomPageTitle extends StatelessWidget {
  final String title;
  final Color? textColor;
  final TextAlign textAlign;
  const CustomPageTitle({
    super.key,
    required this.title,
    this.textAlign = TextAlign.center,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: defaultTitleStyle1.copyWith(color: textColor ?? Theme.of(context).canvasColor),
      textAlign: textAlign,
    );
  }
}
