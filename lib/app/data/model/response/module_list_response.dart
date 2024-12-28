import 'dart:convert';
/// id : 2
/// module_index : 1
/// chapter_id : 2
/// picture : "picture"
/// createdAt : "2024-12-22T09:17:25.003Z"
/// updatedAt : "2024-12-22T09:17:25.003Z"
/// deletedAt : "2024-12-22T09:17:25.003Z"
/// Module_language : [{"id":2,"module_id":2,"language_type":"EN","name":"name","description":"description","createdAt":"2024-12-22T09:17:25.003Z","updatedAt":"2024-12-22T09:17:25.003Z","deletedAt":"2024-12-22T09:17:25.003Z"}]

ModuleListResponse moduleListResponseFromJson(String str) => ModuleListResponse.fromJson(json.decode(str));
String moduleListResponseToJson(ModuleListResponse data) => json.encode(data.toJson());
class ModuleListResponse {
  ModuleListResponse({
      num? id, 
      num? moduleIndex, 
      num? chapterId, 
      String? picture, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt, 
      List<ModuleLanguage>? moduleLanguage,}){
    _id = id;
    _moduleIndex = moduleIndex;
    _chapterId = chapterId;
    _picture = picture;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _moduleLanguage = moduleLanguage;
}

  ModuleListResponse.fromJson(dynamic json) {
    _id = json['id'];
    _moduleIndex = json['module_index'];
    _chapterId = json['chapter_id'];
    _picture = json['picture'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
    if (json['Module_language'] != null) {
      _moduleLanguage = [];
      json['Module_language'].forEach((v) {
        _moduleLanguage?.add(ModuleLanguage.fromJson(v));
      });
    }
  }
  num? _id;
  num? _moduleIndex;
  num? _chapterId;
  String? _picture;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
  List<ModuleLanguage>? _moduleLanguage;
ModuleListResponse copyWith({  num? id,
  num? moduleIndex,
  num? chapterId,
  String? picture,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
  List<ModuleLanguage>? moduleLanguage,
}) => ModuleListResponse(  id: id ?? _id,
  moduleIndex: moduleIndex ?? _moduleIndex,
  chapterId: chapterId ?? _chapterId,
  picture: picture ?? _picture,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  moduleLanguage: moduleLanguage ?? _moduleLanguage,
);
  num? get id => _id;
  num? get moduleIndex => _moduleIndex;
  num? get chapterId => _chapterId;
  String? get picture => _picture;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;
  List<ModuleLanguage>? get moduleLanguage => _moduleLanguage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['module_index'] = _moduleIndex;
    map['chapter_id'] = _chapterId;
    map['picture'] = _picture;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    if (_moduleLanguage != null) {
      map['Module_language'] = _moduleLanguage?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// module_id : 2
/// language_type : "EN"
/// name : "name"
/// description : "description"
/// createdAt : "2024-12-22T09:17:25.003Z"
/// updatedAt : "2024-12-22T09:17:25.003Z"
/// deletedAt : "2024-12-22T09:17:25.003Z"

ModuleLanguage moduleLanguageFromJson(String str) => ModuleLanguage.fromJson(json.decode(str));
String moduleLanguageToJson(ModuleLanguage data) => json.encode(data.toJson());
class ModuleLanguage {
  ModuleLanguage({
      num? id, 
      num? moduleId, 
      String? languageType, 
      String? name, 
      String? description, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt,}){
    _id = id;
    _moduleId = moduleId;
    _languageType = languageType;
    _name = name;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  ModuleLanguage.fromJson(dynamic json) {
    _id = json['id'];
    _moduleId = json['module_id'];
    _languageType = json['language_type'];
    _name = json['name'];
    _description = json['description'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
  }
  num? _id;
  num? _moduleId;
  String? _languageType;
  String? _name;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
ModuleLanguage copyWith({  num? id,
  num? moduleId,
  String? languageType,
  String? name,
  String? description,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
}) => ModuleLanguage(  id: id ?? _id,
  moduleId: moduleId ?? _moduleId,
  languageType: languageType ?? _languageType,
  name: name ?? _name,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  num? get id => _id;
  num? get moduleId => _moduleId;
  String? get languageType => _languageType;
  String? get name => _name;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['module_id'] = _moduleId;
    map['language_type'] = _languageType;
    map['name'] = _name;
    map['description'] = _description;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    return map;
  }

}