import 'dart:convert';

class OrderModel {
  List<String> productList;
  DateTime time;
  double totalPrice;

  OrderModel({
    required this.productList,
    required this.time,
    required this.totalPrice,
  });

  OrderModel copyWith({
    List<String>? productList,
    DateTime? time,
    double? totalPrice,
  }) {
    return OrderModel(
      productList: productList ?? this.productList,
      time: time ?? this.time,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productList': productList,
      'time': time.toIso8601String(),
      'totalPrice': totalPrice,
    };
  }

  static OrderModel fromMap(Map<String, dynamic> map) {
    return OrderModel(
      productList: List<String>.from(map['productList']),
      time: DateTime.parse(map['time']),
      totalPrice: map['totalPrice'],
    );
  }

  static OrderModel fromJson(String json) {
    final map = jsonDecode(json);
    return OrderModel.fromMap(map);
  }

  String toJson() {
    final map = toMap();
    return jsonEncode(map);
  }

  @override
  String toString() {
    return 'OrderModel(productList: $productList, time: $time, totalPrice: $totalPrice)';
  }
}
