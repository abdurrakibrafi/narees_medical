class StateAndCityModel {
  StateAndCityModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final List<StateCityData>? data;

  factory StateAndCityModel.fromJson(Map<String, dynamic> json) {
    return StateAndCityModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<StateCityData>.from(
              json["data"]!.map((x) => StateCityData.fromJson(x))),
    );
  }
}

class StateCityData {
  StateCityData({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.cities,
    required this.stateId,
  });

  final String? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<StateCityData> cities;
  final String? stateId;

  factory StateCityData.fromJson(Map<String, dynamic> json) {
    return StateCityData(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      cities: json["cities"] == null
          ? []
          : List<StateCityData>.from(
              json["cities"]!.map((x) => StateCityData.fromJson(x))),
      stateId: json["stateId"],
    );
  }
}
