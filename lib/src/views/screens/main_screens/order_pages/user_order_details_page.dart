import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/models/pojo_models/order_model.dart';
import 'package:food_shop/src/models/pojo_models/product_model.dart';
import 'package:food_shop/src/views/widgets/product_card.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class UserOrderDetailsPage extends StatefulWidget {
  final OrderModel orderModel;
  const UserOrderDetailsPage({super.key, required this.orderModel});

  @override
  State<UserOrderDetailsPage> createState() => _UserOrderDetailsPageState();
}

class _UserOrderDetailsPageState extends State<UserOrderDetailsPage> {
  final DataController dataController = Get.find();
  final RxBool isLoading = false.obs;
  final RxList<ProductModel> products = RxList();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    isLoading.value = true;
    products.value = await dataController.getProduct(productList: widget.orderModel.productList);
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order details"),
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return RefreshIndicator(
          onRefresh: () async => await loadData(),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: BoxConstraints(minHeight: boxConstraints.maxHeight + 0.01, minWidth: boxConstraints.maxWidth),
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: Obx(
                  () => Wrap(
                    alignment: WrapAlignment.center,
                    spacing: defaultPadding / 4,
                    runSpacing: defaultPadding,
                    children: [
                      for (var e in products)
                        ProductCard(
                          productModel: e,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(defaultPadding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Total Price: ${widget.orderModel.totalPrice.toStringAsFixed(2)} taka", style: buttonText1),
            const SizedBox(height: defaultPadding / 4),
            Text("Total items: ${widget.orderModel.productList.length}", style: buttonText1),
            const SizedBox(height: defaultPadding / 4),
            Text("Standard Delivery: ${DateFormat('yyyy/MM/dd - hh:mm a').format(widget.orderModel.time)}", style: buttonText1),
          ],
        ),
      ),
    );
  }
}
