import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/screen_controllers.dart/seller_wrapped_screen_controller.dart';
import 'package:food_shop/src/controllers/screen_controllers.dart/setting_wrapped_screen_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/screens/main_screens/wrapped_screens/seller_wrapped_screens/seller_add_product_screen.dart';
import 'package:food_shop/src/views/widgets/bottom_nav_bar.dart';
import 'package:food_shop/src/views/widgets/custom_alive.dart';
import 'package:get/get.dart';

class SellerWrappedScreen extends StatefulWidget {
  const SellerWrappedScreen({super.key});

  @override
  State<SellerWrappedScreen> createState() => _SellerWrappedScreenState();
}

class _SellerWrappedScreenState extends State<SellerWrappedScreen> {
  final SellerWrappedScreenController sellerWrappedScreenController = Get.put(SellerWrappedScreenController());
  final SettingWrappedScreenController settingWrappedScreenController = Get.find();

  @override
  void dispose() {
    super.dispose();
    Get.delete<SellerWrappedScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: CustomAlive(child: sellerWrappedScreenController.tabList[sellerWrappedScreenController.currentTabIndex.value].page),
        floatingActionButton: sellerWrappedScreenController.currentTabIndex.value == 0
            ? FloatingActionButton.small(
                elevation: 1,
                onPressed: () => Get.to(() => const SellerAddProductScreen()),
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(boxShadow: defaultBoxShadowUp),
          child: Material(
            color: Theme.of(context).cardColor,
            child: Row(
              children: [
                for (int i = 0; i < sellerWrappedScreenController.tabList.length; i++)
                  BottomNavBar(
                    onTap: () => sellerWrappedScreenController.changeIndex(i),
                    child: Icon(
                      sellerWrappedScreenController.tabList[i].icon,
                      color: i == sellerWrappedScreenController.currentTabIndex.value ? Theme.of(context).primaryColor : null,
                    ),
                  ),
                BottomNavBar(
                  onTap: () => settingWrappedScreenController.changeIndex(true),
                  child: const Icon(
                    Icons.settings,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
