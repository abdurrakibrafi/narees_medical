class PatientProfileModel {
  PatientProfileModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory PatientProfileModel.fromJson(Map<String, dynamic> json){
    return PatientProfileModel(
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
    required this.location,
    required this.phoneNumber,
    required this.stripeAccountId,
    required this.savedPaymentMethod,
    required this.isSaveCard,
    required this.nurseInfo,
    required this.certificates,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? fullname;
  final String? email;
  final String? role;
  final dynamic profilePicture;
  final bool? isDelete;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? specialty;
  final String? location;
  final String? phoneNumber;
  final String? stripeAccountId;
  final dynamic savedPaymentMethod;
  final bool? isSaveCard;
  final NurseInfo? nurseInfo;
  final List<dynamic> certificates;

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
      location: json["location"],
      phoneNumber: json["phoneNumber"],
      stripeAccountId: json["stripeAccountId"],
      savedPaymentMethod: json["savedPaymentMethod"],
      isSaveCard: json["isSaveCard"],
      nurseInfo: json["nurseInfo"] == null ? null : NurseInfo.fromJson(json["nurseInfo"]),
      certificates: json["certificates"] == null ? [] : List<dynamic>.from(json["certificates"]!.map((x) => x)),
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
    required this.serviceArea,
    required this.createdAt,
    required this.updatedAt,
    required this.nurseDocuments,
    required this.nurseServiceAreas,
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
  final List<dynamic> serviceArea;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic> nurseDocuments;
  final List<NurseServiceArea> nurseServiceAreas;

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
      serviceArea: json["serviceArea"] == null ? [] : List<dynamic>.from(json["serviceArea"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      nurseDocuments: json["nurseDocuments"] == null ? [] : List<dynamic>.from(json["nurseDocuments"]!.map((x) => x)),
      nurseServiceAreas: json["nurseServiceAreas"] == null ? [] : List<NurseServiceArea>.from(json["nurseServiceAreas"]!.map((x) => NurseServiceArea.fromJson(x))),
    );
  }

}

class NurseServiceArea {
  NurseServiceArea({
    required this.city,
  });

  final City? city;

  factory NurseServiceArea.fromJson(Map<String, dynamic> json){
    return NurseServiceArea(
      city: json["city"] == null ? null : City.fromJson(json["city"]),
    );
  }

}

class City {
  City({
    required this.id,
    required this.name,
    required this.stateId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? stateId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory City.fromJson(Map<String, dynamic> json){
    return City(
      id: json["id"],
      name: json["name"],
      stateId: json["stateId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
