import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData extends GetxController {
  SharedPreferences? _sharedPreferences;
  final String isSeller = "isActive";

  Future<bool> initData() async {
    if (kDebugMode) print("LocalData: Loading local user data.");
    _sharedPreferences = await SharedPreferences.getInstance();
    bool isActive = _sharedPreferences?.getBool(isSeller) ?? false;
    if (kDebugMode) print("LocalData: isSeller = $isActive");
    return isActive;
  }

  setIsSeller(bool isActive) {
    if (kDebugMode) print("LocalData: isSeller = $isActive");
    _sharedPreferences?.setBool(isSeller, isActive);
  }
}
