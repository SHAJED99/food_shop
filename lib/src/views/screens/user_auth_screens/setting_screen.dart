// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/controllers/screen_controllers.dart/setting_wrapped_screen_controller.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/widgets/custom_background_image.dart';
import 'package:food_shop/src/views/widgets/custom_elevated_button_widget.dart';
import 'package:food_shop/src/views/widgets/custom_page_title.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final DataController dataController = Get.find();
  final SettingWrappedScreenController settingWrappedScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        settingWrappedScreenController.changeIndex(false);
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).primaryColor.withBlue(10).withGreen(10).withRed(10),
              pinned: true,
              expandedHeight: defaultCarouselHeight,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    image: DecorationImage(
                      image: AssetImage("lib/assets/images/login_page_1.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + defaultPadding, left: defaultPadding, right: defaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataController.user.value?.email ?? "",
                          style: defaultSubtitle1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              title: Text("${dataController.user.value?.firstName.capitalizeFirst ?? ""} ${dataController.user.value?.lastName.capitalizeFirst ?? ""}"),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(defaultNavBarHeight),
                child: Obx(
                  () => CustomElevatedButton(
                    backgroundColor: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(defaultPadding)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    onDone: (_) => dataController.isSeller.value = !dataController.isSeller.value,
                    child: Row(
                      children: [
                        Text(
                          "Seller Mode",
                          style: buttonText1.copyWith(color: defaultBlackColor),
                        ),
                        const Spacer(),
                        AnimatedScale(
                          scale: dataController.isSeller.value ? 1 : 0,
                          duration: const Duration(milliseconds: defaultDuration),
                          child: Icon(
                            size: defaultPadding * 2,
                            shadows: defaultBoxShadowDown,
                            Icons.done_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: 2000,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
