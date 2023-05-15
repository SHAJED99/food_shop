import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/screens/user_auth_screens/user_profile.dart';
import 'package:food_shop/src/views/widgets/custom_elevated_button_widget.dart';
import 'package:get/get.dart';

class MainWrappedScreen extends StatelessWidget {
  MainWrappedScreen({super.key});

  final DataController dataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("${(dataController.user.value?.firstName ?? "").capitalizeFirst} ${(dataController.user.value?.lastName ?? "").capitalizeFirst}")),
        actions: [
          AspectRatio(
            aspectRatio: 1,
            child: CustomElevatedButton(
              margin: const EdgeInsets.all(defaultPadding / 4),
              height: null,
              contentPadding: const EdgeInsets.all(defaultPadding / 2),
              borderRadius: BorderRadius.circular(100),
              child: const Expanded(child: FittedBox(child: Icon(Icons.person))),
              onDone: (_) {
                Get.to(() => UserProfile());
              },
            ),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
