// To parse this JSON data, do
//
//     final addChapter = addChapterFromJson(jsonString);

import 'dart:convert';

AddChapter addChapterFromJson(String str) =>
    AddChapter.fromJson(json.decode(str));

String addChapterToJson(AddChapter data) => json.encode(data.toJson());

class AddChapter {
  List<Chapter> chapters;

  AddChapter({
    required this.chapters,
  });

  factory AddChapter.fromJson(Map<String, dynamic> json) => AddChapter(
        chapters: List<Chapter>.from(
            json["chapters"].map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
      };
}

class Chapter {
  int chapterId;
  int chapterIndex;
  int isFree;
  String name;
  String picture;
  DateTime createdAt;
  int maxModule;
  List<Instruction> instructions;

  Chapter({
    required this.chapterId,
    required this.chapterIndex,
    required this.isFree,
    required this.name,
    required this.picture,
    required this.createdAt,
    required this.maxModule,
    required this.instructions,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapterId: json["chapter_id"] ?? 0,
        chapterIndex: json["chapter_index"] ?? 0,
        isFree: json["is_free"] ?? 0,
        name: json["name"] ?? "",
        picture: json["picture"] ?? "",
        createdAt:
            DateTime.parse(json["created_at"] ?? DateTime.now().toString()),
        maxModule: json["max_module"] ?? 0,
        instructions: List<Instruction>.from(
            json["instructions"].map((x) => Instruction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chapter_id": chapterId,
        "chapter_index": chapterIndex,
        "is_free": isFree,
        "name": name,
        "picture": picture,
        "created_at": createdAt.toIso8601String(),
        "max_module": maxModule,
        "instructions": List<dynamic>.from(instructions.map((x) => x.toJson())),
      };
}

class Instruction {
  int id;
  int chapterId;
  dynamic title;
  String description;
  DateTime createdAt;

  Instruction({
    required this.id,
    required this.chapterId,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) => Instruction(
        id: json["id"],
        chapterId: json["chapter_id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chapter_id": chapterId,
        "title": title,
        "description": description,
        "created_at": createdAt.toIso8601String(),
      };
}
