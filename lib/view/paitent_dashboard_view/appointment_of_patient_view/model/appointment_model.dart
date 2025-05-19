class AppointmentModel {
  AppointmentModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
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
  final List<AppointmentData> data;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<AppointmentData>.from(
              json["data"]!.map((x) => AppointmentData.fromJson(x))),
    );
  }
}

class AppointmentData {
  AppointmentData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.patientId,
    required this.nurseId,
    required this.date,
    required this.treatmentType,
    required this.location,
    required this.zipCode,
    required this.phoneNumber,
    required this.reason,
    required this.rejectReason,
    required this.isRemainder,
    required this.canceledByUserId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.appointmentDocuments,
    required this.nurse,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? patientId;
  final String? nurseId;
  final DateTime? date;
  final String? treatmentType;
  final String? location;
  final String? zipCode;
  final String? phoneNumber;
  final String? reason;
  final dynamic rejectReason;
  final bool? isRemainder;
  final dynamic canceledByUserId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<AppointmentDocument> appointmentDocuments;
  final Nurse? nurse;

  factory AppointmentData.fromJson(Map<String, dynamic> json) {
    return AppointmentData(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      patientId: json["patientId"],
      nurseId: json["nurseId"],
      date: DateTime.tryParse(json["date"] ?? ""),
      treatmentType: json["treatmentType"],
      location: json["location"],
      zipCode: json["zipCode"],
      phoneNumber: json["phoneNumber"],
      reason: json["reason"],
      rejectReason: json["rejectReason"],
      isRemainder: json["isRemainder"],
      canceledByUserId: json["canceledByUserId"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      appointmentDocuments: json["appointmentDocuments"] == null
          ? []
          : List<AppointmentDocument>.from(json["appointmentDocuments"]!
              .map((x) => AppointmentDocument.fromJson(x))),
      nurse: json["nurse"] == null ? null : Nurse.fromJson(json["nurse"]),
    );
  }
}

class AppointmentDocument {
  AppointmentDocument({
    required this.id,
    required this.appointmentId,
    required this.url,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? appointmentId;
  final String? url;
  final String? path;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AppointmentDocument.fromJson(Map<String, dynamic> json) {
    return AppointmentDocument(
      id: json["id"],
      appointmentId: json["appointmentId"],
      url: json["url"],
      path: json["path"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}

class Nurse {
  Nurse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullname,
    required this.profilePicture,
    required this.phoneNumber,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? fullname;
  final String? profilePicture;
  final String? phoneNumber;

  factory Nurse.fromJson(Map<String, dynamic> json) {
    return Nurse(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      fullname: json["fullname"],
      profilePicture: json["profilePicture"],
      phoneNumber: json["phoneNumber"],
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
