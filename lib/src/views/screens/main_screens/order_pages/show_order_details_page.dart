import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/controllers/services/user_message/user_notification.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/widgets/custom_card.dart';
import 'package:food_shop/src/views/widgets/custom_elevated_button_widget.dart';
import 'package:food_shop/src/views/widgets/custom_price_tag.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShowOrderDetailsPage extends StatelessWidget {
  ShowOrderDetailsPage({super.key});
  final DataController dataController = Get.find();

  double countTotalPrice() {
    double res = 0;
    for (var e in dataController.cartProductList) {
      res = res + e.item2.price;
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Order"),
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var e in dataController.cartProductList)
                      CustomCard(
                        margin: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.item2.name, style: defaultTitleStyle1),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber, size: defaultPadding),
                                      Text(e.item2.productRating.toStringAsFixed(2)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            PriceTag(text: "${e.item2.price.toStringAsFixed(2)}\ntaka"),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(defaultPadding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Total Price: ${countTotalPrice().toStringAsFixed(2)} taka", style: buttonText1),
            const SizedBox(height: defaultPadding / 4),
            Text("Total items: ${dataController.cartProductList.length}", style: buttonText1),
            const SizedBox(height: defaultPadding / 4),
            Text("Standard Delivery: ${DateFormat('yyyy/MM/dd - hh:mm a').format(DateTime.now().add(const Duration(hours: 1)))}", style: buttonText1),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: defaultNavBarHeight,
        width: defaultNavBarHeight,
        child: CustomElevatedButton(
          height: null,
          borderRadius: BorderRadius.circular(100),
          onTap: () async {
            return dataController.placeOrder(totalPrice: countTotalPrice());
          },
          onDone: (isSuccess) {
            if (isSuccess ?? false) Get.back();
          },
          child: Icon(
            Icons.done_outlined,
            color: Theme.of(context).canvasColor,
          ),
        ),
      ),
    );
  }
}
