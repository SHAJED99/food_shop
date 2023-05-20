import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/screen_controllers.dart/customer_wrapped_screen_controller.dart';
import 'package:food_shop/src/controllers/screen_controllers.dart/setting_wrapped_screen_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/widgets/bottom_nav_bar.dart';
import 'package:get/get.dart';

class CustomerWrappedScreen extends StatefulWidget {
  const CustomerWrappedScreen({super.key});

  @override
  State<CustomerWrappedScreen> createState() => _CustomerWrappedScreenState();
}

class _CustomerWrappedScreenState extends State<CustomerWrappedScreen> {
  final CustomerWrappedScreenController customerWrappedScreenController = Get.put(CustomerWrappedScreenController());
  final SettingWrappedScreenController settingWrappedScreenController = Get.find();

  @override
  void dispose() {
    super.dispose();
    Get.delete<CustomerWrappedScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: customerWrappedScreenController.tabList[customerWrappedScreenController.currentTabIndex.value].page,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(boxShadow: defaultBoxShadowUp),
          child: Material(
            color: Theme.of(context).cardColor,
            child: Row(
              children: [
                for (int i = 0; i < customerWrappedScreenController.tabList.length; i++)
                  BottomNavBar(
                    onTap: () => customerWrappedScreenController.changeIndex(i),
                    child: Icon(
                      customerWrappedScreenController.tabList[i].icon,
                      color: i == customerWrappedScreenController.currentTabIndex.value ? Theme.of(context).primaryColor : null,
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
