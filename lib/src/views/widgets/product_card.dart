import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/models/pojo_models/product_model.dart';
import 'package:food_shop/src/views/screens/main_screens/product_details.dart';
import 'package:food_shop/src/views/widgets/custom_image_field.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;
  final String? productId;
  final DataController dataController = Get.find();
  ProductCard({
    super.key,
    required this.productModel,
    this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 100),
      width: defaultCarouselHeight,
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(defaultPadding / 2), boxShadow: defaultBoxShadowDown, color: Theme.of(context).canvasColor),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CustomNetworkImage(image: productModel.productImage ?? ""),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2, vertical: defaultPadding / 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel.name,
                      style: defaultSubtitle2.copyWith(color: defaultBlackColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: defaultPadding / 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // price tag
                        Text("${productModel.price} taka", style: defaultSubtitle2.copyWith(color: Theme.of(context).primaryColor, height: 1)),

                        // Rating
                        Row(
                          children: [
                            SizedBox(
                              height: defaultSubtitle2.fontSize,
                              child: const FittedBox(
                                child: Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                ),
                              ),
                            ),
                            const SizedBox(width: defaultPadding / 4),
                            Text(productModel.productRating.toString(), style: defaultSubtitle2.copyWith(color: defaultBlackColor, height: 1)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding / 2),
                  ],
                ),
              )
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.to(() => ProductDetails(
                        productModel: productModel,
                        productId: productId,
                      ));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
