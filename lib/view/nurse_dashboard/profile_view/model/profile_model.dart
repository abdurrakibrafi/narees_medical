class ProfileModel {
  ProfileModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json){
    return ProfileModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullname,
    required this.email,
    required this.role,
    required this.profilePicture,
    required this.isDelete,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.specialty,
    required this.nurseInfo,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? fullname;
  final String? email;
  final String? role;
  final String? profilePicture;
  final bool? isDelete;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? specialty;
  final NurseInfo? nurseInfo;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      fullname: json["fullname"],
      email: json["email"],
      role: json["role"],
      profilePicture: json["profilePicture"],
      isDelete: json["isDelete"],
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      specialty: json["specialty"],
      nurseInfo: json["nurseInfo"] == null ? null : NurseInfo.fromJson(json["nurseInfo"]),
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
  final dynamic sunday;
  final dynamic monday;
  final dynamic tuesday;
  final dynamic wednesday;
  final dynamic thursday;
  final dynamic friday;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<NurseDocument> nurseDocuments;

  factory NurseInfo.fromJson(Map<String, dynamic> json){
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
      nurseDocuments: json["nurseDocuments"] == null ? [] : List<NurseDocument>.from(json["nurseDocuments"]!.map((x) => NurseDocument.fromJson(x))),
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

  factory NurseDocument.fromJson(Map<String, dynamic> json){
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
