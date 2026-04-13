class CourseListModel {
  CourseListModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final List<CourseList>? data;

  factory CourseListModel.fromJson(Map<String, dynamic> json) {
    return CourseListModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<CourseList>.from(
              json["data"]!.map((x) => CourseList.fromJson(x))),
    );
  }
}

class CourseList {
  CourseList({
    required this.id,
    required this.courseName,
    required this.certificateUrl,
    required this.certificatePath,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.count,
  });

  final String? id;
  final String? courseName;
  final String? certificateUrl;
  final String? certificatePath;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Count? count;

  factory CourseList.fromJson(Map<String, dynamic> json) {
    return CourseList(
      id: json["id"],
      courseName: json["courseName"],
      certificateUrl: json["certificateUrl"],
      certificatePath: json["certificatePath"],
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
    );
  }
}

class Count {
  Count({
    required this.modules,
  });

  final int? modules;

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      modules: json["modules"],
    );
  }
}
