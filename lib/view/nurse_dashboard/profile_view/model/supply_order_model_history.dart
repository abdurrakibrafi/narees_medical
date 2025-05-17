class SupplyOrderModel {
  SupplyOrderModel({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  final bool? success;
  final String? message;
  final Meta? meta;
  final List<Order>? data;

  factory SupplyOrderModel.fromJson(Map<String, dynamic> json) {
    return SupplyOrderModel(
      success: json["success"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
    );
  }
}

class Order {
  Order({
    required this.id,
    required this.userId,
    required this.status,
    required this.paymentStatus,
    required this.transId,
    required this.createdAt,
    required this.updatedAt,
    required this.payment,
    required this.orderItems,
  });

  final String? id;
  final String? userId;
  final String? status;
  final String? paymentStatus;
  final String? transId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Payment? payment;
  final List<OrderItem> orderItems;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      userId: json["userId"],
      status: json["status"],
      paymentStatus: json["paymentStatus"],
      transId: json["transId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      payment:
          json["payment"] == null ? null : Payment.fromJson(json["payment"]),
      orderItems: json["orderItems"] == null
          ? []
          : List<OrderItem>.from(
              json["orderItems"]!.map((x) => OrderItem.fromJson(x))),
    );
  }
}

class OrderItem {
  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  final String? id;
  final String? orderId;
  final String? productId;
  final int? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json["id"],
      orderId: json["orderId"],
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
    );
  }
}

class Payment {
  Payment({
    required this.id,
    required this.amount,
    required this.status,
    required this.receptUrl,
  });

  final String? id;
  final double? amount;
  final String? status;
  final dynamic receptUrl;

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json["id"],
      amount: json["amount"],
      status: json["status"],
      receptUrl: json["receptUrl"],
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
