import 'dart:convert';
/// id : 4
/// chapter_index : 1
/// is_free : true
/// picture : "picture"
/// createdAt : "2024-12-23T10:03:56.204Z"
/// updatedAt : "2024-12-23T10:03:56.204Z"
/// deletedAt : "2024-12-23T10:03:56.204Z"
/// Chapter_language : [{"id":6,"chapter_id":4,"language_type":"EN","name":"ch 1","createdAt":"2024-12-23T10:03:56.204Z","updatedAt":"2024-12-23T10:03:56.204Z","deletedAt":"2024-12-23T10:03:56.204Z"}]
/// Instructions : [{"id":6,"chapter_id":4,"description":"<p>testt</p>","language_type":"EN","createdAt":"2024-12-23T10:03:56.204Z","updatedAt":"2024-12-23T10:03:56.204Z","deletedAt":"2024-12-23T10:03:56.204Z"}]
/// Chapter_module : [{"id":4}]

ChapterListResponse chapterListResponseFromJson(String str) => ChapterListResponse.fromJson(json.decode(str));
String chapterListResponseToJson(ChapterListResponse data) => json.encode(data.toJson());
class ChapterListResponse {
  ChapterListResponse({
      num? id, 
      num? chapterIndex, 
      bool? isFree, 
      String? picture, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt, 
      List<ChapterLanguage>? chapterLanguage, 
      List<Instructions>? instructions, 
      List<ChapterModule>? chapterModule,}){
    _id = id;
    _chapterIndex = chapterIndex;
    _isFree = isFree;
    _picture = picture;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _chapterLanguage = chapterLanguage;
    _instructions = instructions;
    _chapterModule = chapterModule;
}

  ChapterListResponse.fromJson(dynamic json) {
    _id = json['id'];
    _chapterIndex = json['chapter_index'];
    _isFree = json['is_free'];
    _picture = json['picture'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
    if (json['Chapter_language'] != null) {
      _chapterLanguage = [];
      json['Chapter_language'].forEach((v) {
        _chapterLanguage?.add(ChapterLanguage.fromJson(v));
      });
    }
    if (json['Instructions'] != null) {
      _instructions = [];
      json['Instructions'].forEach((v) {
        _instructions?.add(Instructions.fromJson(v));
      });
    }
    if (json['Chapter_module'] != null) {
      _chapterModule = [];
      json['Chapter_module'].forEach((v) {
        _chapterModule?.add(ChapterModule.fromJson(v));
      });
    }
  }
  num? _id;
  num? _chapterIndex;
  bool? _isFree;
  String? _picture;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
  List<ChapterLanguage>? _chapterLanguage;
  List<Instructions>? _instructions;
  List<ChapterModule>? _chapterModule;
ChapterListResponse copyWith({  num? id,
  num? chapterIndex,
  bool? isFree,
  String? picture,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
  List<ChapterLanguage>? chapterLanguage,
  List<Instructions>? instructions,
  List<ChapterModule>? chapterModule,
}) => ChapterListResponse(  id: id ?? _id,
  chapterIndex: chapterIndex ?? _chapterIndex,
  isFree: isFree ?? _isFree,
  picture: picture ?? _picture,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  chapterLanguage: chapterLanguage ?? _chapterLanguage,
  instructions: instructions ?? _instructions,
  chapterModule: chapterModule ?? _chapterModule,
);
  num? get id => _id;
  num? get chapterIndex => _chapterIndex;
  bool? get isFree => _isFree;
  String? get picture => _picture;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;
  List<ChapterLanguage>? get chapterLanguage => _chapterLanguage;
  List<Instructions>? get instructions => _instructions;
  List<ChapterModule>? get chapterModule => _chapterModule;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['chapter_index'] = _chapterIndex;
    map['is_free'] = _isFree;
    map['picture'] = _picture;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    if (_chapterLanguage != null) {
      map['Chapter_language'] = _chapterLanguage?.map((v) => v.toJson()).toList();
    }
    if (_instructions != null) {
      map['Instructions'] = _instructions?.map((v) => v.toJson()).toList();
    }
    if (_chapterModule != null) {
      map['Chapter_module'] = _chapterModule?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 4

ChapterModule chapterModuleFromJson(String str) => ChapterModule.fromJson(json.decode(str));
String chapterModuleToJson(ChapterModule data) => json.encode(data.toJson());
class ChapterModule {
  ChapterModule({
      num? id,}){
    _id = id;
}

  ChapterModule.fromJson(dynamic json) {
    _id = json['id'];
  }
  num? _id;
ChapterModule copyWith({  num? id,
}) => ChapterModule(  id: id ?? _id,
);
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    return map;
  }

}

/// id : 6
/// chapter_id : 4
/// description : "<p>testt</p>"
/// language_type : "EN"
/// createdAt : "2024-12-23T10:03:56.204Z"
/// updatedAt : "2024-12-23T10:03:56.204Z"
/// deletedAt : "2024-12-23T10:03:56.204Z"

Instructions instructionsFromJson(String str) => Instructions.fromJson(json.decode(str));
String instructionsToJson(Instructions data) => json.encode(data.toJson());
class Instructions {
  Instructions({
      num? id, 
      num? chapterId, 
      String? description, 
      String? languageType, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt,}){
    _id = id;
    _chapterId = chapterId;
    _description = description;
    _languageType = languageType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  Instructions.fromJson(dynamic json) {
    _id = json['id'];
    _chapterId = json['chapter_id'];
    _description = json['description'];
    _languageType = json['language_type'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
  }
  num? _id;
  num? _chapterId;
  String? _description;
  String? _languageType;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
Instructions copyWith({  num? id,
  num? chapterId,
  String? description,
  String? languageType,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
}) => Instructions(  id: id ?? _id,
  chapterId: chapterId ?? _chapterId,
  description: description ?? _description,
  languageType: languageType ?? _languageType,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  num? get id => _id;
  num? get chapterId => _chapterId;
  String? get description => _description;
  String? get languageType => _languageType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['chapter_id'] = _chapterId;
    map['description'] = _description;
    map['language_type'] = _languageType;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    return map;
  }

}

/// id : 6
/// chapter_id : 4
/// language_type : "EN"
/// name : "ch 1"
/// createdAt : "2024-12-23T10:03:56.204Z"
/// updatedAt : "2024-12-23T10:03:56.204Z"
/// deletedAt : "2024-12-23T10:03:56.204Z"

ChapterLanguage chapterLanguageFromJson(String str) => ChapterLanguage.fromJson(json.decode(str));
String chapterLanguageToJson(ChapterLanguage data) => json.encode(data.toJson());
class ChapterLanguage {
  ChapterLanguage({
      num? id, 
      num? chapterId, 
      String? languageType, 
      String? name, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt,}){
    _id = id;
    _chapterId = chapterId;
    _languageType = languageType;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  ChapterLanguage.fromJson(dynamic json) {
    _id = json['id'];
    _chapterId = json['chapter_id'];
    _languageType = json['language_type'];
    _name = json['name'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
  }
  num? _id;
  num? _chapterId;
  String? _languageType;
  String? _name;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
ChapterLanguage copyWith({  num? id,
  num? chapterId,
  String? languageType,
  String? name,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
}) => ChapterLanguage(  id: id ?? _id,
  chapterId: chapterId ?? _chapterId,
  languageType: languageType ?? _languageType,
  name: name ?? _name,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  num? get id => _id;
  num? get chapterId => _chapterId;
  String? get languageType => _languageType;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['chapter_id'] = _chapterId;
    map['language_type'] = _languageType;
    map['name'] = _name;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    return map;
  }

}