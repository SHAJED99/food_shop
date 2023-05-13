import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/screens/user_auth_screen/welcome_screen.dart';
import 'package:get/get.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Food Panddu",
      debugShowCheckedModeBanner: false,
      initialBinding: InitializedBinding(),
      theme: ThemeData(
        primarySwatch: defaultPrimarySwatch,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: defaultPrimarySwatch).copyWith(
          error: defaultErrorColor,
        ),
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
      }),
      home: WelcomeScreen(),
    );
  }
}

class InitializedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DataController());
  }
}
