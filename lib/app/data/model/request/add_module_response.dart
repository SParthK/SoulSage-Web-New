import 'dart:convert';
/// module_index : 2
/// chapter_id : 4
/// picture : "picture"
/// language_type : "EN"
/// name : "name"
/// description : "description"

AddModuleResponse addModuleResponseFromJson(String str) => AddModuleResponse.fromJson(json.decode(str));
String addModuleResponseToJson(AddModuleResponse data) => json.encode(data.toJson());
class AddModuleResponse {
  AddModuleResponse({
      num? moduleIndex, 
      num? chapterId, 
      String? picture, 
      String? languageType, 
      String? name, 
      String? description,}){
    _moduleIndex = moduleIndex;
    _chapterId = chapterId;
    _picture = picture;
    _languageType = languageType;
    _name = name;
    _description = description;
}

  AddModuleResponse.fromJson(dynamic json) {
    _moduleIndex = json['module_index'];
    _chapterId = json['chapter_id'];
    _picture = json['picture'];
    _languageType = json['language_type'];
    _name = json['name'];
    _description = json['description'];
  }
  num? _moduleIndex;
  num? _chapterId;
  String? _picture;
  String? _languageType;
  String? _name;
  String? _description;
AddModuleResponse copyWith({  num? moduleIndex,
  num? chapterId,
  String? picture,
  String? languageType,
  String? name,
  String? description,
}) => AddModuleResponse(  moduleIndex: moduleIndex ?? _moduleIndex,
  chapterId: chapterId ?? _chapterId,
  picture: picture ?? _picture,
  languageType: languageType ?? _languageType,
  name: name ?? _name,
  description: description ?? _description,
);
  num? get moduleIndex => _moduleIndex;
  num? get chapterId => _chapterId;
  String? get picture => _picture;
  String? get languageType => _languageType;
  String? get name => _name;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['module_index'] = _moduleIndex;
    map['chapter_id'] = _chapterId;
    map['picture'] = _picture;
    map['language_type'] = _languageType;
    map['name'] = _name;
    map['description'] = _description;
    return map;
  }

}