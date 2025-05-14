class CartGetModel {
  CartGetModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final List<CartData>? data;

  factory CartGetModel.fromJson(Map<String, dynamic> json) {
    return CartGetModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<CartData>.from(json["data"]!.map((x) => CartData.fromJson(x))),
    );
  }
}

class CartData {
  CartData({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.cartItem,
  });

  final String? id;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<CartItem> cartItem;

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json["id"],
      userId: json["userId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      cartItem: json["cartItem"] == null
          ? []
          : List<CartItem>.from(
              json["cartItem"]!.map((x) => CartItem.fromJson(x))),
    );
  }
}

class CartItem {
  CartItem({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  final String? id;
  final String? cartId;
  final String? productId;
  final int? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json["id"],
      cartId: json["cartId"],
      productId: json["productId"],
      quantity: json["quantity"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      product:
          json["product"] == null ? null : Product.fromJson(json["product"]),
    );
  }
}

class Product {
  Product({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.totalCost,
    required this.stockStatus,
    required this.supplierName,
    required this.description,
    required this.productFor,
    required this.tags,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.productImages,
  });

  final String? id;
  final String? productId;
  final String? name;
  final double? price;
  final int? quantity;
  final double? totalCost;
  final String? stockStatus;
  final String? supplierName;
  final String? description;
  final String? productFor;
  final List<String> tags;
  final DateTime? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProductImage> productImages;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      productId: json["productId"],
      name: json["name"],
      price: json["price"],
      quantity: json["quantity"],
      totalCost: json["totalCost"],
      stockStatus: json["stockStatus"],
      supplierName: json["supplierName"],
      description: json["description"],
      productFor: json["productFor"],
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]!.map((x) => x)),
      date: DateTime.tryParse(json["date"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      productImages: json["productImages"] == null
          ? []
          : List<ProductImage>.from(
              json["productImages"]!.map((x) => ProductImage.fromJson(x))),
    );
  }
}

class ProductImage {
  ProductImage({
    required this.id,
    required this.productId,
    required this.url,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? productId;
  final String? url;
  final String? path;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json["id"],
      productId: json["productId"],
      url: json["url"],
      path: json["path"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}
