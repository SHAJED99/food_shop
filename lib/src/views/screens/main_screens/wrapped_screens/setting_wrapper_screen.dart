import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/screen_controllers.dart/setting_wrapped_screen_controller.dart';
import 'package:food_shop/src/views/screens/main_screens/wrapped_screens/main_wrapped_screen.dart';
import 'package:food_shop/src/views/screens/user_auth_screens/setting_screen.dart';
import 'package:get/get.dart';

class SettingWrapperScreen extends StatefulWidget {
  const SettingWrapperScreen({super.key});

  @override
  State<SettingWrapperScreen> createState() => _SettingWrapperScreenState();
}

class _SettingWrapperScreenState extends State<SettingWrapperScreen> {
  final SettingWrappedScreenController settingWrappedScreenController = Get.put(SettingWrappedScreenController());

  @override
  void dispose() {
    super.dispose();
    Get.delete<SettingWrappedScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: settingWrappedScreenController.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        MainWrappedScreen(),
        SettingScreen(),
      ],
    );
  }
}
