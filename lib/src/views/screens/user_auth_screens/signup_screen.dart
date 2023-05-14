import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/controllers/services/functions/email_verification.dart';
import 'package:food_shop/src/controllers/services/functions/password_verification.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/models/pojo_models/user_information_model.dart';
import 'package:food_shop/src/views/screens/main_screens/wrapped_screens/customer_wrapped_screens/cusetomer_wrapped_screen.dart';
import 'package:food_shop/src/views/screens/user_auth_screens/login_screen.dart';
import 'package:food_shop/src/views/widgets/custom_background_image.dart';
import 'package:food_shop/src/views/widgets/custom_elevated_button_widget.dart';
import 'package:food_shop/src/views/widgets/custom_page_title.dart';
import 'package:food_shop/src/views/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final DataController dataController = Get.find();
  final _form = GlobalKey<FormState>();
  final TextEditingController firstNameC = TextEditingController();
  final TextEditingController lastNameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController confirmPasswordC = TextEditingController();

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
                      const CustomPageTitle(title: "Sign Up"),
                      //* First Name
                      const SizedBox(height: defaultPadding * 2),
                      CustomTextFormField(
                        textEditingController: firstNameC,
                        hintText: "First Name",
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value?.isEmpty ?? true) return "Enter First Name";
                        },
                      ),
                      //* Last Name
                      const SizedBox(height: defaultPadding / 2),
                      CustomTextFormField(
                        textEditingController: lastNameC,
                        hintText: "Last Name",
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value?.isEmpty ?? true) return "Enter Last Name";
                        },
                      ),
                      //* Email
                      const SizedBox(height: defaultPadding / 2),
                      CustomTextFormField(
                        textEditingController: emailC,
                        hintText: "Email",
                        textAlign: TextAlign.center,
                        validator: (value) {
                          bool res = checkEmailValidation(value ?? "");
                          if (!res) return "Invalid Email Address";
                        },
                      ),
                      //* Password
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
                      //* Confirm Password
                      const SizedBox(height: defaultPadding / 2),
                      CustomTextFormField(
                        textEditingController: confirmPasswordC,
                        hintText: "Confirm Password",
                        textAlign: TextAlign.center,
                        obscureText: true,
                        validator: (value) {
                          if (value?.isEmpty ?? true) return "Invalid Password";
                          bool res = passwordC.text == value;
                          if (!res) return "Password does not match";
                        },
                      ),
                      // Sign Up
                      const SizedBox(height: defaultPadding),
                      CustomElevatedButton(
                        expanded: true,
                        onTap: () async {
                          bool res = _form.currentState?.validate() ?? false;
                          if (!res) return false;
                          UserInformationModel userInformation = UserInformationModel(firstName: firstNameC.text.trim().toLowerCase(), lastName: lastNameC.text.trim().toLowerCase(), email: emailC.text.trim());
                          return await dataController.signup(userInformation: userInformation, password: passwordC.text);
                        },
                        onDone: (isSuccess) {
                          if (isSuccess ?? false) Get.off(() => CustomerWrappedScreen());
                        },
                        child: const Text("Sign Up", style: buttonText1),
                      ),

                      const SizedBox(height: defaultPadding * 2),
                      // Already have an account? Login
                      CustomElevatedButton(
                        height: 24,
                        onDone: (_) => Get.offAll(() => LoginScreen()),
                        backgroundColor: Colors.transparent,
                        child: Text("Already have an account? Login", style: defaultSubtitle1.copyWith(color: Theme.of(context).canvasColor)),
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
