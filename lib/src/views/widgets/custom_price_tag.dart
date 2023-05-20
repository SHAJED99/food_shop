import 'package:flutter/material.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';

class PriceTag extends StatelessWidget {
  const PriceTag({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).primaryColor,
      ),
      child: Text(
        text,
        style: defaultSubtitle1.copyWith(color: Theme.of(context).cardColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
