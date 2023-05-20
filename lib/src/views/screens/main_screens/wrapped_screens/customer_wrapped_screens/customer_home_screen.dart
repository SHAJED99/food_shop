import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/models/pojo_models/product_model.dart';
import 'package:food_shop/src/views/widgets/custom_loading_bar.dart';
import 'package:food_shop/src/views/widgets/product_card.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final DataController dataController = Get.find();
  bool isLoading = false;
  List<Tuple2<String, ProductModel>> productList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => staring());
  }

  staring() async {
    // await Future.delayed(const Duration(seconds: 3));
    loadData();
  }

  loadData() async {
    if (isLoading) return;
    if (mounted) setState(() => isLoading = true);
    productList = await dataController.getOtherUserProduct();
    if (mounted) setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading && productList.isEmpty) return const Center(child: CustomCircularProgressBar());
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return RefreshIndicator(
        onRefresh: () async => loadData(),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: boxConstraints.maxHeight + 0.01, minWidth: boxConstraints.maxWidth),
            padding: const EdgeInsets.all(defaultPadding / 2),
            child: !isLoading && productList.isEmpty
                ? const Center(
                    child: Text(
                      "Oops! No food here. You can take the responsibility and share happiness.\nGo to seller mood by tapping \"Gear icon\" and active the seller mode.\nOr refresh the page.",
                      style: defaultSubtitle1,
                      textAlign: TextAlign.center,
                    ),
                  )
                : Wrap(
                    alignment: WrapAlignment.center,
                    spacing: defaultPadding / 4,
                    runSpacing: defaultPadding,
                    children: [
                      for (int i = 0; i < productList.length; i++)
                        ProductCard(
                          productModel: productList[i].item2,
                          productId: productList[i].item1,
                        ),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
