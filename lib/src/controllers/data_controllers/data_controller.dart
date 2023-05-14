import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:food_shop/src/controllers/services/firebase/firebase_controller.dart';
import 'package:food_shop/src/controllers/services/handle_error/error_handler.dart';
import 'package:food_shop/src/controllers/services/user_message/snackbar.dart';
import 'package:food_shop/src/models/pojo_models/return_type.dart';
import 'package:food_shop/src/models/pojo_models/user_information_model.dart';
import 'package:food_shop/src/views/screens/main_screens/wrapped_screens/main_wrapped_screen.dart';
import 'package:food_shop/src/views/screens/user_auth_screens/login_screen.dart';

import 'package:get/get.dart';

class DataController extends GetxController {
  final FirebaseController _firebaseController = FirebaseController();

  RxBool isRequesting = false.obs;

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

    // Check if login
    if (FirebaseAuth.instance.currentUser != null) {
      // if valid then go to main page
      Get.offAll(() => MainWrappedScreen());
    }
    bool force = false;
    FirebaseAuth.instance.userChanges().listen((event) {
      if (force) {
        if (kDebugMode) print("DataController.init(): FirebaseAuth.instance.userChanges().listen() for User ${event?.email}");
        if (event == null) Get.offAll(() => LoginScreen());
      } else {
        force = true;
      }
    });
    _readUserAuth();
  }

  Future<void> _readUserAuth() async {
    // Check if login user is valid
    await _errorHandler(function: () async => await FirebaseAuth.instance.currentUser?.reload());
  }

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
    ReturnType res = await _errorHandler(function: () async => _firebaseController.login(email, password));
    if (res.isValid) {
      showSnackBar(title: "Success", message: "Login Successful");
    }

    return res.isValid;
  }
  //! //////////////////////////////////////////////////////////////////////////
}
