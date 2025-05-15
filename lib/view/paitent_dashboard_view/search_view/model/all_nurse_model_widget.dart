class AllNurseModel {
  AllNurseModel({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  final bool? success;
  final String? message;
  final Meta? meta;
  final List<AllNurse>? data;

  factory AllNurseModel.fromJson(Map<String, dynamic> json) {
    return AllNurseModel(
      success: json["success"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<AllNurse>.from(json["data"]!.map((x) => AllNurse.fromJson(x))),
    );
  }
}

class AllNurse {
  AllNurse({
    required this.id,
    required this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.fullname,
    required this.profilePicture,
    required this.isDelete,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.specialty,
    required this.nurseInfo,
    required this.phoneNumber,
    required this.location,
  });

  final String? id;
  final String? email;
  final String? role;
  final String? firstName;
  final String? lastName;
  final String? fullname;
  final String? profilePicture;
  final bool? isDelete;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? specialty;
  final NurseInfo? nurseInfo;
  final String? phoneNumber;
  final String? location;

  factory AllNurse.fromJson(Map<String, dynamic> json) {
    return AllNurse(
      id: json["id"],
      email: json["email"],
      role: json["role"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      fullname: json["fullname"],
      profilePicture: json["profilePicture"],
      isDelete: json["isDelete"],
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      specialty: json["specialty"],
      nurseInfo: json["nurseInfo"] == null
          ? null
          : NurseInfo.fromJson(json["nurseInfo"]),
      phoneNumber: json["phoneNumber"],
      location: json["location"],
    );
  }
}

class NurseInfo {
  NurseInfo({
    required this.id,
    required this.userId,
    required this.registeredId,
    required this.signature,
    required this.signaturePath,
    required this.saturday,
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.createdAt,
    required this.updatedAt,
    required this.nurseDocuments,
  });

  final String? id;
  final String? userId;
  final String? registeredId;
  final String? signature;
  final String? signaturePath;
  final dynamic saturday;
  final String? sunday;
  final dynamic monday;
  final dynamic tuesday;
  final dynamic wednesday;
  final dynamic thursday;
  final dynamic friday;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<NurseDocument> nurseDocuments;

  factory NurseInfo.fromJson(Map<String, dynamic> json) {
    return NurseInfo(
      id: json["id"],
      userId: json["userId"],
      registeredId: json["registeredId"],
      signature: json["signature"],
      signaturePath: json["signaturePath"],
      saturday: json["saturday"],
      sunday: json["sunday"],
      monday: json["monday"],
      tuesday: json["tuesday"],
      wednesday: json["wednesday"],
      thursday: json["thursday"],
      friday: json["friday"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      nurseDocuments: json["nurseDocuments"] == null
          ? []
          : List<NurseDocument>.from(
              json["nurseDocuments"]!.map((x) => NurseDocument.fromJson(x))),
    );
  }
}

class NurseDocument {
  NurseDocument({
    required this.id,
    required this.nurseId,
    required this.url,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? nurseId;
  final String? url;
  final String? path;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory NurseDocument.fromJson(Map<String, dynamic> json) {
    return NurseDocument(
      id: json["id"],
      nurseId: json["nurseId"],
      url: json["url"],
      path: json["path"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}

class Meta {
  Meta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPage,
  });

  final int? total;
  final int? page;
  final int? limit;
  final int? totalPage;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json["total"],
      page: json["page"],
      limit: json["limit"],
      totalPage: json["totalPage"],
    );
  }
}
