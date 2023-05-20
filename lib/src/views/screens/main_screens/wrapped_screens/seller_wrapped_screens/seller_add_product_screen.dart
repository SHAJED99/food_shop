import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/controllers/services/functions/email_verification.dart';
import 'package:food_shop/src/controllers/services/user_message/snackbar.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/models/pojo_models/product_model.dart';
import 'package:food_shop/src/views/widgets/custom_elevated_button_widget.dart';
import 'package:food_shop/src/views/widgets/custom_page_title.dart';
import 'package:food_shop/src/views/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class SellerAddProductScreen extends StatefulWidget {
  const SellerAddProductScreen({super.key});

  @override
  State<SellerAddProductScreen> createState() => _SellerAddProductScreenState();
}

class _SellerAddProductScreenState extends State<SellerAddProductScreen> {
  final DataController dataController = Get.find();
  final _form = GlobalKey<FormState>();
  final TextEditingController productNameC = TextEditingController();
  final TextEditingController productDescriptionC = TextEditingController();
  final TextEditingController productPriceC = TextEditingController();
  final TextEditingController imageLinkC = TextEditingController();

  double price = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    CustomPageTitle(title: "Product Details", textColor: Theme.of(context).primaryColor),

                    //* Product Name
                    const SizedBox(height: defaultPadding * 2),
                    CustomTextFormField(
                      textEditingController: productNameC,
                      labelText: "Product Name",
                      validator: (value) {
                        if (value?.isEmpty ?? true) return "Enter Product Name";
                      },
                    ),

                    //* Product Description
                    const SizedBox(height: defaultPadding / 2),
                    CustomTextFormField(
                      textEditingController: productDescriptionC,
                      labelText: "Product Description",
                      height: null,
                      minLines: 3,
                      maxLines: 5,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return "Enter Product Description";
                      },
                    ),

                    //* Product Price
                    const SizedBox(height: defaultPadding / 2),
                    CustomTextFormField(
                      textEditingController: productPriceC,
                      labelText: "Product Price",
                      suffix: const Text(" Taka"),
                      validator: (value) {
                        if (value?.isNotEmpty ?? false) {
                          try {
                            price = double.parse(value ?? "0");
                          } catch (e) {
                            return "Enter Valid Price";
                          }
                        }
                        if (value?.isEmpty ?? true) return "Enter Product Price";
                      },
                    ),

                    //* Email
                    const SizedBox(height: defaultPadding / 2),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomTextFormField(
                            initialValue: FirebaseAuth.instance.currentUser?.email,
                            enabled: false,
                            labelText: "Email",
                          ),
                        ),
                        const SizedBox(width: defaultPadding / 2),
                        const Flexible(
                          child: CustomTextFormField(
                            initialValue: "5.00",
                            enabled: false,
                            labelText: "Rating",
                          ),
                        )
                      ],
                    ),
                    //* Image
                    const SizedBox(height: defaultPadding / 2),
                    CustomTextFormField(
                      textEditingController: imageLinkC,
                      labelText: "Image Link",
                      validator: (value) {
                        bool res = checkEmailValidation(value ?? "");
                        if (!res) return "Invalid Email Address";
                      },
                    ),

                    // Submit button
                    const SizedBox(height: defaultPadding),
                    CustomElevatedButton(
                      expanded: true,
                      onTap: () async {
                        bool res = _form.currentState?.validate() ?? false;
                        if (!res) return false;
                        ProductModel temp = ProductModel(
                          name: productNameC.text,
                          description: productDescriptionC.text,
                          price: price,
                          productRating: 5.00,
                          productImage: imageLinkC.text,
                          supplier: FirebaseAuth.instance.currentUser?.email ?? "",
                        );

                        return await dataController.addProduct(productModel: temp);
                      },
                      onDone: (isSuccess) {
                        if (isSuccess ?? false) {
                          Get.back();
                          showSnackBar(title: "Success", message: "Product Created");
                        }
                      },
                      child: const Text("Create Product", style: buttonText1),
                    ),
                    const SizedBox(height: defaultPadding * 2),
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
