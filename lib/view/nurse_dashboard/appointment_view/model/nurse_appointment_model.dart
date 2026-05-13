class NurseAppointmentModel {
  NurseAppointmentModel({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  final bool? success;
  final String? message;
  final Meta? meta;
  final List<NurseData>? data;

  factory NurseAppointmentModel.fromJson(Map<String, dynamic> json) {
    return NurseAppointmentModel(
      success: json["success"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null
          ? []
          : List<NurseData>.from(
              json["data"]!.map((x) => NurseData.fromJson(x))),
    );
  }
}

class NurseData {
  NurseData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.patientId,
    required this.nurseId,
    required this.cityId,
    required this.date,
    required this.treatmentType,
    required this.location,
    required this.zipCode,
    required this.phoneNumber,
    required this.reason,
    required this.isRemainder,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.appointmentDocuments,
    required this.cityRef,
    required this.patient,
    required this.nurse,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? patientId;
  final String? nurseId;
  final String? cityId;
  final DateTime? date;
  final String? treatmentType;
  final dynamic location;
  final String? zipCode;
  final String? phoneNumber;
  final String? reason;
  final bool? isRemainder;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic> appointmentDocuments;
  final CityRef? cityRef;
  final Nurse? patient;
  final Nurse? nurse;

  factory NurseData.fromJson(Map<String, dynamic> json) {
    return NurseData(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      patientId: json["patientId"],
      nurseId: json["nurseId"],
      cityId: json["cityId"],
      date: DateTime.tryParse(json["date"] ?? ""),
      treatmentType: json["treatmentType"],
      location: json["location"],
      zipCode: json["zipCode"],
      phoneNumber: json["phoneNumber"],
      reason: json["reason"],
      isRemainder: json["isRemainder"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      appointmentDocuments: json["appointmentDocuments"] == null
          ? []
          : List<dynamic>.from(json["appointmentDocuments"]!.map((x) => x)),
      cityRef:
          json["cityRef"] == null ? null : CityRef.fromJson(json["cityRef"]),
      patient: json["patient"] == null ? null : Nurse.fromJson(json["patient"]),
      nurse: json["nurse"] == null ? null : Nurse.fromJson(json["nurse"]),
    );
  }
}

class CityRef {
  CityRef({
    required this.id,
    required this.name,
    required this.stateId,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
  });

  final String? id;
  final String? name;
  final String? stateId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final State? state;

  factory CityRef.fromJson(Map<String, dynamic> json) {
    return CityRef(
      id: json["id"],
      name: json["name"],
      stateId: json["stateId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      state: json["state"] == null ? null : State.fromJson(json["state"]),
    );
  }
}

class State {
  State({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json["id"],
      name: json["name"],
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
