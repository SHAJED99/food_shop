import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/controllers/services/functions/email_verification.dart';
import 'package:food_shop/src/controllers/services/functions/password_verification.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/screens/user_auth_screens/reset_password_screen.dart';
import 'package:food_shop/src/views/screens/user_auth_screens/signup_screen.dart';
import 'package:food_shop/src/views/widgets/custom_background_image.dart';
import 'package:food_shop/src/views/widgets/custom_elevated_button_widget.dart';
import 'package:food_shop/src/views/widgets/custom_page_title.dart';
import 'package:food_shop/src/views/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final DataController dataController = Get.find();
  final _form = GlobalKey<FormState>();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Form(
            key: _form,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: defaultMaxWidth),
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      // Title
                      const SizedBox(height: defaultPadding * 2),
                      const CustomPageTitle(title: "Login"),
                      // User Name
                      const SizedBox(height: defaultPadding * 2),
                      CustomTextFormField(
                        textEditingController: emailC,
                        hintText: "Email",
                        textAlign: TextAlign.center,
                        validator: (value) {
                          bool res = checkEmailValidation(value ?? "");
                          if (!res) return "Invalid Email Address";
                        },
                      ),
                      // Password
                      const SizedBox(height: defaultPadding / 2),
                      CustomTextFormField(
                        textEditingController: passwordC,
                        hintText: "Password",
                        textAlign: TextAlign.center,
                        obscureText: true,
                        validator: (value) {
                          bool res = checkPasswordValidation(value ?? "");
                          if (!res) return "Invalid Password";
                        },
                      ),
                      // Login
                      const SizedBox(height: defaultPadding),
                      CustomElevatedButton(
                        expanded: true,
                        onTap: () async {
                          return await dataController.login(email: emailC.text.trim(), password: passwordC.text.trim());
                        },
                        child: const Text("Login", style: buttonText1),
                      ),

                      const SizedBox(height: defaultPadding / 2),
                      // Forgot password?
                      CustomElevatedButton(
                        height: 24,
                        onDone: (_) => Get.offAll(() => ResetPasswordScreen()),
                        backgroundColor: Colors.transparent,
                        child: Text("Forgot password?", style: defaultSubtitle1.copyWith(color: Theme.of(context).canvasColor)),
                      ),
                      const SizedBox(height: defaultPadding * 2),
                      // Sign up
                      CustomElevatedButton(
                        height: 24,
                        onDone: (_) => Get.offAll(() => SignupScreen()),
                        backgroundColor: Colors.transparent,
                        child: Text("Sign up", style: defaultSubtitle1.copyWith(color: Theme.of(context).canvasColor)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
