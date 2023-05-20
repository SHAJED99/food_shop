class UserInformationModel {
  final String firstName;
  final String lastName;
  final String email;
  final List<String> activeOrder;
  final List<String> cancelOrder;
  final List<String> completedOrder;
  final List<String> activeSelling;
  final List<String> cancelSelling;
  final List<String> completedSelling;
  // final Map<String, List<String>> orderList;
  // final Map<String, List<String>> sellingOrderList;
  final List<String> productList;

  UserInformationModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    // required this.orderList,
    // required this.sellingOrderList,
    required this.productList,
    required this.activeOrder,
    required this.cancelOrder,
    required this.completedOrder,
    required this.activeSelling,
    required this.cancelSelling,
    required this.completedSelling,
  });

  factory UserInformationModel.fromJson(Map<String, dynamic> json) {
    return UserInformationModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      // orderList: Map<String, List<String>>.from(json['orderList']),
      // sellingOrderList: Map<String, List<String>>.from(json['sellingOrderList']),
      productList: List<String>.from(json['productList']),
      activeOrder: List<String>.from(json['activeOrder']),
      cancelOrder: List<String>.from(json['cancelOrder']),
      completedOrder: List<String>.from(json['completedOrder']),
      activeSelling: List<String>.from(json['activeSelling']),
      cancelSelling: List<String>.from(json['cancelSelling']),
      completedSelling: List<String>.from(json['completedSelling']),
    );
  }

  factory UserInformationModel.fromMap(Map<String, dynamic> map) {
    // Map<String, List<String>> con(String name) {
    //   Map<String, List<String>> temp = {};
    //   if (map[name] == null) return {};
    //   map[name].forEach((key, value) {
    //     temp[key] = [];
    //     value.forEach((e) {
    //       temp[key]?.add(e.toString());
    //     });
    //   });
    //   return temp;
    // }

    return UserInformationModel(
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      email: map['email'] ?? "",
      // orderList: con('orderList'),
      // sellingOrderList: con('sellingOrderList'),
      productList: List<String>.from(map['productList'] ?? []),
      activeOrder: List<String>.from(map['activeOrder'] ?? []),
      cancelOrder: List<String>.from(map['cancelOrder'] ?? []),
      completedOrder: List<String>.from(map['completedOrder'] ?? []),
      activeSelling: List<String>.from(map['activeSelling'] ?? []),
      cancelSelling: List<String>.from(map['cancelSelling'] ?? []),
      completedSelling: List<String>.from(map['completedSelling'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      // 'orderList': orderList,
      // 'sellingOrderList': sellingOrderList,
      'productList': productList,
      'activeOrder': activeOrder,
      'cancelOrder': cancelOrder,
      'completedOrder': completedOrder,
      'activeSelling': activeSelling,
      'cancelSelling': cancelSelling,
      'completedSelling': completedSelling,
    };
  }

  UserInformationModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    // Map<String, List<String>>? orderList,
    // Map<String, List<String>>? sellingOrderList,
    List<String>? productList,
    List<String>? activeOrder,
    List<String>? cancelOrder,
    List<String>? completedOrder,
    List<String>? activeSelling,
    List<String>? cancelSelling,
    List<String>? completedSelling,
  }) {
    return UserInformationModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      // orderList: orderList ?? this.orderList,
      // sellingOrderList: sellingOrderList ?? this.sellingOrderList,
      productList: productList ?? this.productList,
      activeOrder: activeOrder ?? this.activeOrder,
      cancelOrder: cancelOrder ?? this.cancelOrder,
      completedOrder: completedOrder ?? this.completedOrder,
      activeSelling: activeSelling ?? this.activeSelling,
      cancelSelling: cancelSelling ?? this.cancelSelling,
      completedSelling: completedSelling ?? this.completedSelling,
    );
  }

  @override
  String toString() {
    return 'UserInformationModel{firstName: $firstName, lastName: $lastName, email: $email, productList: $productList}';
  }
}
