class SettingsModel {
  SettingsModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory SettingsModel.fromJson(Map<String, dynamic> json){
    return SettingsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.privacy,
    required this.terms,
  });

  final String? id;
  final String? privacy;
  final String? terms;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      privacy: json["privacy"],
      terms: json["terms"],
    );
  }

}
