import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:food_shop/src/controllers/services/firebase/firebase_controller.dart';
import 'package:food_shop/src/controllers/services/handle_error/error_handler.dart';
import 'package:food_shop/src/controllers/services/local_data/local_data.dart';
import 'package:food_shop/src/controllers/services/user_message/snackbar.dart';
import 'package:food_shop/src/controllers/services/user_message/user_notification.dart';
import 'package:food_shop/src/models/pojo_models/order_model.dart';
import 'package:food_shop/src/models/pojo_models/product_model.dart';
import 'package:food_shop/src/models/pojo_models/return_type.dart';
import 'package:food_shop/src/models/pojo_models/user_information_model.dart';
import 'package:food_shop/src/views/screens/main_screens/wrapped_screens/setting_wrapper_screen.dart';
import 'package:food_shop/src/views/screens/user_auth_screens/login_screen.dart';

import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class DataController extends GetxController {
  final FirebaseController _firebaseController = FirebaseController();
  final LocalData _localData = LocalData();
  final NotificationService _notificationService = NotificationService();
  final RxBool isSeller = false.obs;
  Rx<UserInformationModel?> user = Rxn();
  RxBool isRequesting = false.obs;
  RxList<Tuple2<String, ProductModel>> cartProductList = RxList();

  //! Error handler ////////////////////////////////////////////////////////////
  Future<ReturnType<T>> _errorHandler<T>({bool showError = true, required Function function}) async {
    isRequesting.value = true;
    T? value;
    bool isValid = await ErrorHandler.errorHandler(
      showError: showError,
      function: () async => value = await function(),
    );
    isRequesting.value = false;
    return ReturnType(value: value, isValid: isValid);
  }
  //! //////////////////////////////////////////////////////////////////////////

  Future<void> init() async {
    // Initialize Firebase dependency
    await Future.delayed(const Duration(seconds: 3));
    await _firebaseController.initFirebase();
    isSeller.value = await _localData.initData();
    await _notificationService.initNotification();
    isSeller.listen((_) => _localData.setIsSeller(isSeller.value));
    await _readUserAuth();
    await _readUserStatus();

    bool force = false;
    FirebaseAuth.instance.userChanges().listen((event) async {
      if (kDebugMode) print("DataController.init(): FirebaseAuth.instance.userChanges().listen() for User ${event?.email}");
      if (FirebaseAuth.instance.currentUser != null) {
        await _readUserStatus();
      }
      if (force) {
        if (FirebaseAuth.instance.currentUser == null) Get.offAll(() => LoginScreen());
      } else {
        force = true;
      }
    });

    // Check if login
    if (FirebaseAuth.instance.currentUser != null) {
      // if valid then go to main page
      Get.offAll(() => const SettingWrapperScreen());
    }
  }

  // Check if login user is valid
  Future<void> _readUserAuth() async {
    if (FirebaseAuth.instance.currentUser != null) await _errorHandler(function: () async => await FirebaseAuth.instance.currentUser?.reload());
  }

  Future<void> _readUserStatus() async {
    if (FirebaseAuth.instance.currentUser != null) await _errorHandler(function: () async => user.value = await _firebaseController.fetchUserData());
  }

  Future<void> readData() async => await _readUserStatus();

  //! Auth /////////////////////////////////////////////////////////////////////
  //* signup
  Future<bool> signup({required UserInformationModel userInformation, required String password}) async {
    ReturnType res = await _errorHandler<UserCredential>(function: () async => _firebaseController.signup(userInformation, password));
    if (res.isValid) {
      showSnackBar(title: "Success", message: "Account has been created");
    }
    return res.isValid;
  }

  //* login
  Future<bool> login({required String email, required String password}) async {
    ReturnType res = await _errorHandler(function: () async => await _firebaseController.login(email, password));
    if (res.isValid) {
      showSnackBar(title: "Success", message: "Login Successful");
    }
    return res.isValid;
  }

  signOut() {
    cartProductList.value = [];
    user.value = null;
    isSeller.value = false;
    FirebaseAuth.instance.signOut();
  }
  //! //////////////////////////////////////////////////////////////////////////

  //! Product //////////////////////////////////////////////////////////////////
  Future<bool> addProduct({required ProductModel productModel}) async {
    ReturnType res = await _errorHandler(function: () async => await _firebaseController.addProduct(productModel));
    await _readUserStatus();
    return res.isValid;
  }

  Future<List<ProductModel>> getProduct({List<String>? productList}) async {
    if (user.value?.productList.isEmpty ?? true) return [];
    ReturnType res = await _errorHandler(function: () async => await _firebaseController.getProduct(productList ?? user.value!.productList));
    return res.value ?? [];
  }

  Future<List<Tuple2<String, ProductModel>>> getOtherUserProduct() async {
    ReturnType res = await _errorHandler(function: () async => await _firebaseController.getOtherUserProductList(user.value?.productList ?? []));
    return res.value ?? [];
  }
  //! //////////////////////////////////////////////////////////////////////////

  //! Order ////////////////////////////////////////////////////////////////////
  Future<bool> placeOrder({required double totalPrice}) async {
    ReturnType res = await _errorHandler(function: () async {
      List<String> products = [];
      for (var e in cartProductList) {
        products.add(e.item1);
      }
      String id = await _firebaseController.placeOrder(
        OrderModel(productList: products, time: DateTime.now(), totalPrice: totalPrice),
      );
      cartProductList.value = [];
      _readUserStatus();
      _notificationService.showNotification(title: "Order Placed", body: "Order Id: $id\nYou will get update within 20 minutes");
      _notificationService.showNotificationAfterTime(title: "Order Placed", body: "Order Id: $id\nCheck you order update.", duration: const Duration(minutes: 20));
    });

    return res.isValid;
  }

  Future<List<OrderModel>> loadOrder({required String orderId}) async {
    List<String> orderListId = [];

    if (orderId == 'activeOrder') {
      orderListId.addAll(user.value?.activeOrder ?? []);
    } else if (orderId == 'completedOrder') {
      orderListId.addAll(user.value?.completedOrder ?? []);
    } else if (orderId == 'cancelOrder') {
      orderListId.addAll(user.value?.cancelOrder ?? []);
    }

    if (orderListId.isEmpty) return [];

    ReturnType res = await _errorHandler(function: () async {
      return await _firebaseController.loadOrder(orderId, orderListId);
    });

    return res.value ?? [];
  }
  //! //////////////////////////////////////////////////////////////////////////
}
