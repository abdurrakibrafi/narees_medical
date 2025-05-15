class MarketingMaterialModel {
  MarketingMaterialModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory MarketingMaterialModel.fromJson(Map<String, dynamic> json) {
    return MarketingMaterialModel(
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
  final List<MarketData> data;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<MarketData>.from(
              json["data"]!.map((x) => MarketData.fromJson(x))),
    );
  }
}

class MarketData {
  MarketData({
    required this.id,
    required this.content,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.marketingMaterialDocument,
  });

  final String? id;
  final String? content;
  final List<String> tags;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<MarketingMaterialDocument> marketingMaterialDocument;

  factory MarketData.fromJson(Map<String, dynamic> json) {
    return MarketData(
      id: json["id"],
      content: json["content"],
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      marketingMaterialDocument: json["marketingMaterialDocument"] == null
          ? []
          : List<MarketingMaterialDocument>.from(
              json["marketingMaterialDocument"]!
                  .map((x) => MarketingMaterialDocument.fromJson(x))),
    );
  }
}

class MarketingMaterialDocument {
  MarketingMaterialDocument({
    required this.id,
    required this.url,
    required this.path,
    required this.marketingMaterialId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? url;
  final String? path;
  final String? marketingMaterialId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory MarketingMaterialDocument.fromJson(Map<String, dynamic> json) {
    return MarketingMaterialDocument(
      id: json["id"],
      url: json["url"],
      path: json["path"],
      marketingMaterialId: json["marketingMaterialId"],
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
