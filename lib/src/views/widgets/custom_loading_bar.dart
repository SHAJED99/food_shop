import 'package:flutter/material.dart';

class CustomCircularProgressBar extends StatelessWidget {
  const CustomCircularProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 25, height: 25, child: CircularProgressIndicator());
  }
}
