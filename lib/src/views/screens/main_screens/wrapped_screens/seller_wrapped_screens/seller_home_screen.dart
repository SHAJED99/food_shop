// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/models/pojo_models/product_model.dart';
import 'package:food_shop/src/views/widgets/custom_loading_bar.dart';
import 'package:food_shop/src/views/widgets/product_card.dart';
import 'package:get/get.dart';

class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({super.key});

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  final DataController dataController = Get.find();
  bool isLoading = false;
  List<ProductModel> productList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => staring());
  }

  staring() async {
    // await Future.delayed(Duration(seconds: 3));
    loadData();
  }

  loadData() async {
    if (isLoading) return;
    if (mounted) setState(() => isLoading = true);
    productList = await dataController.getProduct();
    if (mounted) setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading && productList.isEmpty) return Center(child: CustomCircularProgressBar());

    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return RefreshIndicator(
        onRefresh: () async => loadData(),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: boxConstraints.maxHeight + 0.01, minWidth: boxConstraints.maxWidth),
            padding: EdgeInsets.all(defaultPadding / 2),
            child: !isLoading && productList.isEmpty
                ? const Center(
                    child: Text(
                      "Oops! No food here.\nTap the \"+ button\" and start sharing happiness.\nOr refresh the page.",
                      style: defaultSubtitle1,
                      textAlign: TextAlign.center,
                    ),
                  )
                : Wrap(
                    // runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    spacing: defaultPadding / 4,
                    runSpacing: defaultPadding,
                    children: [
                      for (ProductModel e in productList)
                        ProductCard(
                          productModel: e,
                        ),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
