import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:food_shop/src/controllers/services/firebase/firebase_controller.dart';
import 'package:food_shop/src/controllers/services/handle_error/error_handler.dart';
import 'package:food_shop/src/controllers/services/user_message/snackbar.dart';
import 'package:food_shop/src/models/pojo_models/return_type.dart';
import 'package:food_shop/src/models/pojo_models/user_information.dart';
import 'package:food_shop/src/views/screens/user_auth_screen/login_screen.dart';
import 'package:food_shop/src/views/screens/user_auth_screen/welcome_screen.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  final FirebaseController _firebaseController = FirebaseController();
  Rx<UserCredential?> userCredential = Rxn();
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

  DataController() {
    userCredential.listen((_) {});
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3));
    await _firebaseController.initFirebase();
  }

  //! Auth /////////////////////////////////////////////////////////////////////
  //* signup
  Future<bool> signup({required UserInformation userInformation, required String password}) async {
    ReturnType res = await _errorHandler<UserCredential>(function: () async => _firebaseController.signup(userInformation, password));
    if (res.isValid) {
      showSnackBar(title: "Success", message: "Account has been created");
      userCredential.value = res.value;
    }
    return res.isValid;
  }

  //* login
  Future<bool> login({required String email, required String password}) async {
    ReturnType res = await _errorHandler<UserCredential>(function: () async => _firebaseController.login(email, password));
    if (res.isValid) {
      showSnackBar(title: "Success", message: "Login Successful");
      userCredential.value = res.value;
    }
    print(userCredential.value.toString());
    return res.isValid;
  }
  //! //////////////////////////////////////////////////////////////////////////
}
