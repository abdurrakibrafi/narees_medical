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
  final dynamic specialty;
  final dynamic location;
  final String? phoneNumber;
  final dynamic stripeAccountId;
  final dynamic savedPaymentMethod;
  final bool? isSaveCard;

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
    );
  }

}
