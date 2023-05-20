import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/widgets/custom_elevated_button_widget.dart';
import 'package:get/get.dart';

class CustomEndSideDrawer extends StatelessWidget {
  CustomEndSideDrawer({super.key});
  final DataController dataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: defaultMaxWidth),
        margin: EdgeInsets.only(left: defaultBoxHeight, top: MediaQuery.of(context).padding.top),
        padding: const EdgeInsets.all(defaultPadding),
        color: Theme.of(context).canvasColor,
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${dataController.user.value?.firstName.capitalizeFirst} ${dataController.user.value?.lastName.capitalizeFirst}", style: defaultSubtitle1.copyWith(color: defaultBlackColor)),
                      const SizedBox(height: defaultPadding / 8),
                      Text("${dataController.user.value?.email}", style: defaultSubtitle2.copyWith(color: defaultBlackColor)),
                    ],
                  ),
                ),
              ),
              CustomElevatedButton(
                expanded: true,
                onDone: (_) => dataController.signOut(),
                child: const Text("Log out", style: buttonText1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
