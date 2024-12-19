// To parse this JSON data, do
//
//     final moduleModel = moduleModelFromJson(jsonString);

import 'dart:convert';

ModuleModel moduleModelFromJson(String str) =>
    ModuleModel.fromJson(json.decode(str));

String moduleModelToJson(ModuleModel data) => json.encode(data.toJson());

class ModuleModel {
  List<Module> modules;

  ModuleModel({
    required this.modules,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) => ModuleModel(
        modules:
            List<Module>.from(json["Modules"].map((x) => Module.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Modules": List<dynamic>.from(modules.map((x) => x.toJson())),
      };
}

class Module {
  int moduleId;
  int moduleIndex;
  int chapterId;
  String name;
  String description;
  String picture;
  DateTime createdAt;

  Module({
    required this.moduleId,
    required this.moduleIndex,
    required this.chapterId,
    required this.name,
    required this.description,
    required this.picture,
    required this.createdAt,
  });

  factory Module.fromJson(Map<String, dynamic> json) => Module(
        moduleId: json["module_id"] ?? 0,
        moduleIndex: json["module_index"] ?? "",
        chapterId: json["chapter_id"] ?? 0,
        name: json["name"] ?? "",
        description: json["description"] ?? " ",
        picture: json["picture"] ?? "",
        createdAt:
            DateTime.parse(json["created_at"] ?? DateTime.now().toString()),
      );

  Map<String, dynamic> toJson() => {
        "module_id": moduleId,
        "module_index": moduleIndex,
        "chapter_id": chapterId,
        "name": name,
        "description": description,
        "picture": picture,
        "created_at": createdAt.toIso8601String(),
      };
}
