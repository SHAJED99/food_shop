import 'package:flutter/material.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/widgets/custom_elevated_button_widget.dart';

class CustomReactButton extends StatelessWidget {
  final Future<bool?>? Function()? onTap;
  const CustomReactButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onTap: onTap,
      height: defaultPadding,
      width: defaultPadding,
      borderRadius: BorderRadius.circular(4),
      contentPadding: const EdgeInsets.all(defaultPadding / 8),
      child: FittedBox(child: Icon(Icons.favorite_border, color: Theme.of(context).cardColor)),
    );
  }
}
