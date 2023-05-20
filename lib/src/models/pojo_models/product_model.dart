import 'dart:convert';

class ProductModel {
  final String name;
  final String description;
  final double price;
  final double productRating;
  final String? productImage;
  final String supplier;
  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.productRating,
    this.productImage,
    required this.supplier,
  });

  ProductModel copyWith({
    String? name,
    String? description,
    double? price,
    double? productRating,
    String? productImage,
    String? supplier,
  }) {
    return ProductModel(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      productRating: productRating ?? this.productRating,
      productImage: productImage ?? this.productImage,
      supplier: supplier ?? this.supplier,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'productRating': productRating,
      'productImage': productImage,
      'supplier': supplier,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      productRating: map['productRating'] as double,
      productImage: map['productImage'] != null ? map['productImage'] as String : null,
      supplier: map['supplier'] as String,
    );
  }

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(name: $name, description: $description, price: $price, productRating: $productRating, productImage: $productImage, supplier: $supplier)';
  }
}
