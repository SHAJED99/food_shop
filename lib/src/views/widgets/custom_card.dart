import 'package:flutter/material.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.child,
    this.color,
    this.padding = const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2),
    this.margin,
  });
  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding / 2),
        boxShadow: defaultBoxShadowDown,
        color: color ?? Theme.of(context).canvasColor,
      ),
      child: child,
    );
  }
}
