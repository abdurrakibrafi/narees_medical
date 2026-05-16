class PatientChartingModel {
  PatientChartingModel({
     this.success,
     this.message,
     this.meta,
     this.data,
  });

  final bool? success;
  final String? message;
  final Meta? meta;
  final List<PatientCharting>? data;

  factory PatientChartingModel.fromJson(Map<String, dynamic> json){
    return PatientChartingModel(
      success: json["success"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null ? [] : List<PatientCharting>.from(json["data"]!.map((x) => PatientCharting.fromJson(x))),
    );
  }

}

class PatientCharting {
  PatientCharting({
    required this.id,
    required this.appointmentId,
    required this.nurseId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.appointment,
    required this.nurse,
  });

  final String? id;
  final String? appointmentId;
  final String? nurseId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Appointment? appointment;
  final Nurse? nurse;

  factory PatientCharting.fromJson(Map<String, dynamic> json){
    return PatientCharting(
      id: json["id"],
      appointmentId: json["appointmentId"],
      nurseId: json["nurseId"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      appointment: json["appointment"] == null ? null : Appointment.fromJson(json["appointment"]),
      nurse: json["nurse"] == null ? null : Nurse.fromJson(json["nurse"]),
    );
  }

}

class Appointment {
  Appointment({
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
    required this.chartPdfUrl,
    required this.chartSubmittedAt,
    required this.isRemainder,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.cityRef,
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
  final String? chartPdfUrl;
  final DateTime? chartSubmittedAt;
  final bool? isRemainder;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final CityRef? cityRef;

  factory Appointment.fromJson(Map<String, dynamic> json){
    return Appointment(
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
      chartPdfUrl: json["chartPdfUrl"],
      chartSubmittedAt: DateTime.tryParse(json["chartSubmittedAt"] ?? ""),
      isRemainder: json["isRemainder"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      cityRef: json["cityRef"] == null ? null : CityRef.fromJson(json["cityRef"]),
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

  factory CityRef.fromJson(Map<String, dynamic> json){
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

  factory State.fromJson(Map<String, dynamic> json){
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
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.specialty,
    required this.nurseInfo,
    required this.phoneNumber,
    required this.email,
  });

  final String? firstName;
  final String? lastName;
  final String? profilePicture;
  final String? specialty;
  final NurseInfo? nurseInfo;
  final String? phoneNumber;
  final String? email;

  factory Nurse.fromJson(Map<String, dynamic> json){
    return Nurse(
      firstName: json["firstName"],
      lastName: json["lastName"],
      profilePicture: json["profilePicture"],
      specialty: json["specialty"],
      nurseInfo: json["nurseInfo"] == null ? null : NurseInfo.fromJson(json["nurseInfo"]),
      phoneNumber: json["phoneNumber"],
      email: json["email"],
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

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }

}
