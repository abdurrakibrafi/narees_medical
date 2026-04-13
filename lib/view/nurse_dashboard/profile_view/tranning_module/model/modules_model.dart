class ModuleModelClass {
  ModuleModelClass({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final List<ModuleData>? data;

  factory ModuleModelClass.fromJson(Map<String, dynamic> json){
    return ModuleModelClass(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<ModuleData>.from(json["data"]!.map((x) => ModuleData.fromJson(x))),
    );
  }

}

class ModuleData {
  ModuleData({
    required this.id,
    required this.userId,
    required this.trainingModuleId,
    required this.status,
    required this.currentModuleIndex,
    required this.progressPercent,
    required this.createdAt,
    required this.updatedAt,
    required this.trainingModule,
  });

  final String? id;
  final String? userId;
  final String? trainingModuleId;
  final String? status;
  final int? currentModuleIndex;
  final int? progressPercent;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final TrainingModule? trainingModule;

  factory ModuleData.fromJson(Map<String, dynamic> json){
    return ModuleData(
      id: json["id"],
      userId: json["userId"],
      trainingModuleId: json["trainingModuleId"],
      status: json["status"],
      currentModuleIndex: json["currentModuleIndex"],
      progressPercent: json["progressPercent"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      trainingModule: json["trainingModule"] == null ? null : TrainingModule.fromJson(json["trainingModule"]),
    );
  }

}

class TrainingModule {
  TrainingModule({
    required this.id,
    required this.courseName,
    required this.certificateUrl,
    required this.certificatePath,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.modules,
  });

  final String? id;
  final String? courseName;
  final String? certificateUrl;
  final String? certificatePath;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Module> modules;

  factory TrainingModule.fromJson(Map<String, dynamic> json){
    return TrainingModule(
      id: json["id"],
      courseName: json["courseName"],
      certificateUrl: json["certificateUrl"],
      certificatePath: json["certificatePath"],
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      modules: json["modules"] == null ? [] : List<Module>.from(json["modules"]!.map((x) => Module.fromJson(x))),
    );
  }

}

class Module {
  Module({
    required this.id,
    required this.serial,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.videoUId,
    required this.trainingModuleId,
    required this.createdAt,
    required this.updatedAt,
    required this.progresses,
  });

  final String? id;
  final int? serial;
  final String? name;
  final String? description;
  final String? thumbnailUrl;
  final String? videoUrl;
  final String? videoUId;
  final String? trainingModuleId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Progress> progresses;

  factory Module.fromJson(Map<String, dynamic> json){
    return Module(
      id: json["id"],
      serial: json["serial"],
      name: json["name"],
      description: json["description"],
      thumbnailUrl: json["thumbnailUrl"],
      videoUrl: json["videoUrl"],
      videoUId: json["videoUId"],
      trainingModuleId: json["trainingModuleId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      progresses: json["progresses"] == null ? [] : List<Progress>.from(json["progresses"]!.map((x) => Progress.fromJson(x))),
    );
  }

}

class Progress {
  Progress({
    required this.id,
    required this.userId,
    required this.moduleId,
    required this.enrollmentId,
    required this.isUnlocked,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? userId;
  final String? moduleId;
  final String? enrollmentId;
  final bool? isUnlocked;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Progress.fromJson(Map<String, dynamic> json){
    return Progress(
      id: json["id"],
      userId: json["userId"],
      moduleId: json["moduleId"],
      enrollmentId: json["enrollmentId"],
      isUnlocked: json["isUnlocked"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
