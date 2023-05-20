import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/screens/main_screens/order_pages/show_order_details_page.dart';
import 'package:food_shop/src/views/widgets/product_card.dart';
import 'package:get/get.dart';

class CartListPage extends StatelessWidget {
  CartListPage({super.key});
  final DataController dataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: dataController.cartProductList.isEmpty
            ? const Center(
                child: Text(
                  "Oops! Nothing here.\nAdd product to cart and place order.",
                  style: defaultSubtitle1,
                  textAlign: TextAlign.center,
                ),
              )
            : SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: defaultPadding / 4,
                      runSpacing: defaultPadding,
                      children: [
                        for (var e in dataController.cartProductList)
                          ProductCard(
                            productModel: e.item2,
                            productId: e.item1,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
        floatingActionButton: Obx(
          () => dataController.cartProductList.isEmpty
              ? const SizedBox()
              : FloatingActionButton.small(
                  onPressed: () {
                    Get.to(() => ShowOrderDetailsPage());
                  },
                  child: const Icon(Icons.shopping_bag),
                ),
        ),
      ),
    );
  }
}
