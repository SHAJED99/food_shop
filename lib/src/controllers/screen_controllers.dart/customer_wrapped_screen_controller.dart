import 'package:flutter/material.dart';
import 'package:food_shop/src/models/pojo_models/page_list_model.dart';
import 'package:food_shop/src/views/screens/main_screens/order_pages/order_wrapped_page.dart';
import 'package:food_shop/src/views/screens/main_screens/wrapped_screens/customer_wrapped_screens/customer_home_screen.dart';
import 'package:get/get.dart';

class CustomerWrappedScreenController extends GetxController {
  RxInt currentTabIndex = 0.obs;

  List<PageListModel> tabList = [
    PageListModel(icon: Icons.home, name: "Home", page: CustomerHomeScreen()),
    PageListModel(icon: Icons.list_alt, name: "Order", page: OrderWrappedPage()),
  ];

  void changeIndex(int index) {
    currentTabIndex.value = index;
  }
}
