import 'package:flutter/material.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:get/get.dart';

class SettingWrappedScreenController extends GetxController {
  final PageController pageController = PageController();

  changeIndex(bool isSetting) {
    if (pageController.hasClients) {
      pageController.animateToPage(isSetting ? 1 : 0, duration: const Duration(milliseconds: defaultDuration), curve: Curves.linear);
    }
  }
}
