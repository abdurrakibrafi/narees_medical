class ProductModel {
  ProductModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.meta,
    required this.data,
  });

  final Meta? meta;
  final List<Inventory> data;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<Inventory>.from(
              json["data"]!.map((x) => Inventory.fromJson(x))),
    );
  }
}

class Inventory {
  Inventory({
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

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
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

class Meta {
  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }
}
