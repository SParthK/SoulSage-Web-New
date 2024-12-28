import 'dart:convert';
/// name : "chapter 1"
/// is_free : true
/// picture : "picture"
/// chapter_index : 2
/// language_type : "EN"
/// description : "description"
/// instruction : "instruction"

AddChapterRequest addChapterRequestFromJson(String str) => AddChapterRequest.fromJson(json.decode(str));
String addChapterRequestToJson(AddChapterRequest data) => json.encode(data.toJson());
class AddChapterRequest {
  AddChapterRequest({
      String? name, 
      bool? isFree, 
      String? picture, 
      num? chapterIndex, 
      String? languageType, 
      String? description, 
      String? instruction,}){
    _name = name;
    _isFree = isFree;
    _picture = picture;
    _chapterIndex = chapterIndex;
    _languageType = languageType;
    _description = description;
    _instruction = instruction;
}

  AddChapterRequest.fromJson(dynamic json) {
    _name = json['name'];
    _isFree = json['is_free'];
    _picture = json['picture'];
    _chapterIndex = json['chapter_index'];
    _languageType = json['language_type'];
    _description = json['description'];
    _instruction = json['instruction'];
  }
  String? _name;
  bool? _isFree;
  String? _picture;
  num? _chapterIndex;
  String? _languageType;
  String? _description;
  String? _instruction;
AddChapterRequest copyWith({  String? name,
  bool? isFree,
  String? picture,
  num? chapterIndex,
  String? languageType,
  String? description,
  String? instruction,
}) => AddChapterRequest(  name: name ?? _name,
  isFree: isFree ?? _isFree,
  picture: picture ?? _picture,
  chapterIndex: chapterIndex ?? _chapterIndex,
  languageType: languageType ?? _languageType,
  description: description ?? _description,
  instruction: instruction ?? _instruction,
);
  String? get name => _name;
  bool? get isFree => _isFree;
  String? get picture => _picture;
  num? get chapterIndex => _chapterIndex;
  String? get languageType => _languageType;
  String? get description => _description;
  String? get instruction => _instruction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['is_free'] = _isFree;
    map['picture'] = _picture;
    map['chapter_index'] = _chapterIndex;
    map['language_type'] = _languageType;
    map['description'] = _description;
    map['instruction'] = _instruction;
    return map;
  }

}