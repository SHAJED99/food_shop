// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/screens/main_screens/wrapped_screens/customer_wrapped_screens/customer_wrapped_screen.dart';
import 'package:food_shop/src/views/screens/main_screens/wrapped_screens/seller_wrapped_screens/seller_wrapped_screen.dart';
import 'package:food_shop/src/views/widgets/custom_elevated_button_widget.dart';
import 'package:food_shop/src/views/widgets/custom_end_side_drawer.dart';
import 'package:get/get.dart';

class MainWrappedScreen extends StatelessWidget {
  MainWrappedScreen({super.key});

  final DataController dataController = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // key: scaffoldKey,
        appBar: AppBar(
          title: Text("${(dataController.user.value?.firstName ?? "").capitalizeFirst} ${(dataController.user.value?.lastName ?? "").capitalizeFirst}"),
          actions: [
            NavBarButton(
              icon: Icon(Icons.person),
              onDone: (_) {
                scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ],
        ),
        endDrawer: CustomEndSideDrawer(),
        body: dataController.isSeller.value ? SellerWrappedScreen() : CustomerWrappedScreen(),
      ),
    );
  }
}

class NavBarButton extends StatelessWidget {
  final Widget icon;
  final Function(bool? isSuccess)? onDone;
  const NavBarButton({super.key, required this.icon, this.onDone});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomElevatedButton(
        margin: const EdgeInsets.all(defaultPadding / 4),
        height: null,
        contentPadding: const EdgeInsets.all(defaultPadding / 2),
        borderRadius: BorderRadius.circular(100),
        onDone: onDone,
        child: Expanded(child: FittedBox(child: icon)),
      ),
    );
  }
}
