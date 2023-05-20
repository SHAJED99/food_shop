import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/models/pojo_models/product_model.dart';
import 'package:food_shop/src/views/widgets/custom_image_field.dart';
import 'package:food_shop/src/views/widgets/custom_price_tag.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel productModel;
  final String? productId;
  final DataController dataController = Get.find();
  ProductDetails({super.key, required this.productModel, this.productId});
  final RxBool isInCart = true.obs;

  bool checkIfInCart() {
    for (var e in dataController.cartProductList) {
      if (e.item1 == productId) {
        isInCart.value = true;
        return true;
      }
    }
    isInCart.value = false;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productModel.name)),
      floatingActionButton: productId != null
          ? FloatingActionButton.small(
              elevation: 1,
              onPressed: () {
                // Add to cart
                if (productId != null) {
                  if (!isInCart.value) {
                    dataController.cartProductList.add(Tuple2(productId ?? "", productModel));
                  } else {
                    dataController.cartProductList.remove(Tuple2(productId, productModel));
                  }
                }
              },
              child: Obx(() => Icon(checkIfInCart() ? Icons.done : Icons.add_shopping_cart)),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
              width: double.infinity,
              height: defaultCarouselHeight * 2,
              image: productModel.productImage ?? "",
            ),
            Container(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name
                          Text(
                            productModel.name,
                            style: defaultTitleStyle1,
                          ),
                          const SizedBox(height: defaultPadding / 4),
                          // product Rating
                          Row(
                            children: [
                              const Icon(Icons.star, size: defaultPadding, color: Colors.amber),
                              Text(" ${productModel.productRating}", style: defaultSubtitle1.copyWith(color: Colors.amber)),
                            ],
                          ),
                        ],
                      ),
                      PriceTag(text: "${productModel.price.toStringAsFixed(2)}\ntaka")
                    ],
                  ),

                  const SizedBox(height: defaultPadding),
                  // Description
                  Text(
                    productModel.description,
                    textAlign: TextAlign.justify,
                    style: defaultSubtitle1.copyWith(color: defaultBlackColor),
                  ),

                  const SizedBox(height: defaultPadding),
                  // Email
                  Text(
                    "Supplier: ${productModel.supplier}",
                    textAlign: TextAlign.justify,
                    style: defaultSubtitle1,
                  ),

                  const SizedBox(height: defaultPadding * 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
