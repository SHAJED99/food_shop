import 'package:flutter/material.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';

class BottomNavBar extends StatelessWidget {
  final Function() onTap;
  final Icon child;
  const BottomNavBar({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: defaultNavBarHeight,
        child: InkWell(
          onTap: () => onTap(),
          child: child,
        ),
      ),
    );
  }
}
