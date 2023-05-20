import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:food_shop/src/controllers/services/handle_error/app_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ErrorHandler {
  // Handle Error
  static Future<bool> errorHandler({bool showError = true, required Function function}) async {
    try {
      await function();
      return true;
    } on UserAlreadyExistsException {
      if (kDebugMode) print("ErrorHandler: SocketException");
      if (showError) UserAlreadyExistsException();
    } on ServiceUnavailable {
      if (kDebugMode) print("ErrorHandler: ServiceUnavailableException");
      if (showError) ServiceUnavailable();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        if (kDebugMode) print("ErrorHandler: UserAlreadyExistsException");
        if (showError) UserAlreadyExistsException();
      } else if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        if (kDebugMode) print("ErrorHandler: Invalid user");
        if (showError) UserNotFoundException();
      } else {
        if (kDebugMode) print("ErrorHandler: InternalError. ErrorCode: ${e.code}");
        if (showError) InternalError(message: e.code);
      }
    } catch (e) {
      if (kDebugMode) print("ErrorHandler: InternalError. ErrorCode: $e");
      if (showError) InternalError(message: e.toString());
      rethrow;
    }
    return false;
  }
}
