import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/screens/user_auth_screens/login_screen.dart';
import 'package:food_shop/src/views/screens/user_auth_screens/signup_screen.dart';
import 'package:food_shop/src/views/widgets/custom_background_image.dart';
import 'package:food_shop/src/views/widgets/custom_elevated_button_widget.dart';
import 'package:food_shop/src/views/widgets/custom_loading_bar.dart';
import 'package:food_shop/src/views/widgets/custom_page_title.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final DataController dataController = Get.find();
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    dataController.init().then((_) {
      if (mounted) {
        setState(() => isInitialized = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: defaultMaxWidth),
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    const SizedBox(height: defaultPadding * 2),
                    const CustomPageTitle(title: "Welcome to Food Panddu"),
                    const SizedBox(height: defaultPadding / 2),
                    // Subtitle
                    Text("This is a dummy app", style: defaultSubtitle1.copyWith(color: Theme.of(context).canvasColor), textAlign: TextAlign.center),
                    const SizedBox(height: defaultPadding * 2),

                    AnimatedSize(
                      duration: const Duration(milliseconds: defaultDuration),
                      child: !isInitialized
                          ? const CustomCircularProgressBar()
                          : Column(
                              // Login
                              children: [
                                CustomElevatedButton(
                                  iconHeight: defaultPadding * 2,
                                  expanded: true,
                                  onDone: (_) => Get.offAll(() => LoginScreen()),
                                  backgroundColor: Theme.of(context).primaryColor,
                                  child: const Text("Login", style: buttonText1),
                                ),
                                const SizedBox(height: defaultPadding * 2),
                                // Sign up
                                CustomElevatedButton(
                                  height: 24,
                                  onDone: (_) => Get.offAll(() => SignupScreen()),
                                  backgroundColor: Colors.transparent,
                                  child: Text("New user? Sign up", style: defaultSubtitle1.copyWith(color: Theme.of(context).canvasColor)),
                                ),
                              ],
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
