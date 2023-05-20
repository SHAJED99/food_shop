import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/models/pojo_models/order_model.dart';
import 'package:food_shop/src/views/screens/main_screens/order_pages/user_order_details_page.dart';
import 'package:food_shop/src/views/widgets/custom_card.dart';
import 'package:food_shop/src/views/widgets/custom_elevated_button_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderListPage extends StatefulWidget {
  final String orderTitle;
  const OrderListPage({super.key, required this.orderTitle});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final DataController dataController = Get.find();
  final RxBool isLoading = false.obs;
  final RxList<OrderModel> orderList = RxList();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    isLoading.value = true;
    orderList.value = await dataController.loadOrder(orderId: widget.orderTitle);

    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await loadData(),
      child: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return Obx(
          () => SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: boxConstraints.maxHeight + 0.001),
              padding: const EdgeInsets.all(defaultPadding / 2),
              child: Column(
                children: [
                  for (var e in orderList)
                    CustomElevatedButton(
                      backgroundColor: Theme.of(context).canvasColor,
                      boxShadow: defaultBoxShadowDown,
                      margin: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
                      height: null,
                      onTap: () async {
                        Get.to(() => UserOrderDetailsPage(orderModel: e));
                        return;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: defaultPadding / 4),
                              Text("Total Items: ${e.productList.length}", style: defaultTitleStyle1),
                              const SizedBox(height: defaultPadding / 4),
                              Text("Total Price: ${e.totalPrice.toStringAsFixed(2)}", style: defaultSubtitle1.copyWith(color: defaultBlackColor)),
                              const SizedBox(height: defaultPadding / 4),
                              Text(DateFormat('yyyy/MM/dd - hh:mm a').format(e.time), style: defaultSubtitle2),
                              const SizedBox(height: defaultPadding / 4),
                            ],
                          ),
                          const Icon(Icons.arrow_right)
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
