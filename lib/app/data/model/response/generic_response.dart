import 'dart:convert';
/// date : {}
/// success : true
/// message : "Admin logged in successfully"

GenericResponse genericResponseFromJson(String str) => GenericResponse.fromJson(json.decode(str));
String genericResponseToJson(GenericResponse data) => json.encode(data.toJson());
class GenericResponse {
  GenericResponse({
      dynamic data,
      bool? success, 
      String? message,}){
    _data = data;
    _success = success;
    _message = message;
}

  GenericResponse.fromJson(dynamic json) {
    _data = json['data'];
    _success = json['success'];
    _message = json['message'];
  }
  dynamic _data;
  bool? _success;
  String? _message;
GenericResponse copyWith({  dynamic date,
  bool? success,
  String? message,
}) => GenericResponse(  data: date ?? _data,
  success: success ?? _success,
  message: message ?? _message,
);
  dynamic get data => _data;
  bool? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}