import 'package:flutter/material.dart';
import 'package:food_shop/src/controllers/data_controllers/data_controller.dart';
import 'package:food_shop/src/models/app_models/app_constants.dart';
import 'package:food_shop/src/views/screens/main_screens/order_pages/order_wrapped_page/cart_screen.dart';
import 'package:food_shop/src/views/screens/main_screens/order_pages/order_wrapped_page/order_list_page.dart';
import 'package:food_shop/src/views/widgets/bottom_nav_bar.dart';
import 'package:food_shop/src/views/widgets/custom_alive.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class OrderWrappedPage extends StatefulWidget {
  const OrderWrappedPage({super.key});

  @override
  State<OrderWrappedPage> createState() => _OrderWrappedPageState();
}

class _OrderWrappedPageState extends State<OrderWrappedPage> {
  final DataController dataController = Get.find();
  final PageController controller = PageController();

  List<Tuple3<String, IconData, Widget>> pageList = [];

  @override
  void initState() {
    super.initState();

    if (!dataController.isSeller.value) pageList.add(Tuple3("cart", Icons.shopping_cart, CartListPage()));

    pageList.addAll([
      const Tuple3("activeOrder", Icons.play_arrow, OrderListPage(orderTitle: 'activeOrder')),
      const Tuple3("completedOrder", Icons.done_all_sharp, OrderListPage(orderTitle: 'completedOrder')),
      const Tuple3("cancelOrder", Icons.cancel, OrderListPage(orderTitle: 'cancelOrder')),
    ]);
  }

  final RxInt index = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: PageView(
          controller: controller,
          onPageChanged: (value) => index.value = value,
          children: [
            for (int i = 0; i < pageList.length; i++) CustomAlive(child: pageList[i].item3),
          ],
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(defaultNavBarHeight),
          child: Row(
            children: [
              for (int i = 0; i < pageList.length; i++)
                BottomNavBar(
                    onTap: () {
                      index.value = i;
                      controller.animateToPage(i, duration: const Duration(milliseconds: defaultDuration), curve: Curves.linear);
                    },
                    child: Icon(
                      pageList[i].item2,
                      color: index.value == i ? Theme.of(context).primaryColor : null,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
