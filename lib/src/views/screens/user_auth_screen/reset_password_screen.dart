import 'package:flutter/material.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/widgets/custom_background_image.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Form(
                child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: defaultMaxWidth),
              padding: const EdgeInsets.all(defaultPadding),
            ),
          ),
        ))),
      ),
    );
  }
}
