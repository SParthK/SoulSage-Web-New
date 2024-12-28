import 'dart:convert';
/// user : {"id":1,"email":"test@gmail.com","password":"$2b$10$BprJWoGvgp3Zsv3NidbY8exR0hti/.XuBtY.3aQevHO1INTvE.eQm","admin_type":"SuperAdmin","createdAt":"2024-12-19T13:31:00.198Z","updatedAt":"2024-12-19T13:31:00.198Z","deletedAt":null}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzM0NjI2NjQ1fQ.WBEOnO2C1sbo6AroJK-hZczhC-Rs_4_Cdxot3ogQQV4"

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());
class LoginResponse {
  LoginResponse({
      User? user, 
      String? token,}){
    _user = user;
    _token = token;
}

  LoginResponse.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }
  User? _user;
  String? _token;
LoginResponse copyWith({  User? user,
  String? token,
}) => LoginResponse(  user: user ?? _user,
  token: token ?? _token,
);
  User? get user => _user;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    return map;
  }

}

/// id : 1
/// email : "test@gmail.com"
/// password : "$2b$10$BprJWoGvgp3Zsv3NidbY8exR0hti/.XuBtY.3aQevHO1INTvE.eQm"
/// admin_type : "SuperAdmin"
/// createdAt : "2024-12-19T13:31:00.198Z"
/// updatedAt : "2024-12-19T13:31:00.198Z"
/// deletedAt : null

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      num? id, 
      String? email, 
      String? password, 
      String? adminType, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt,}){
    _id = id;
    _email = email;
    _password = password;
    _adminType = adminType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _password = json['password'];
    _adminType = json['admin_type'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
  }
  num? _id;
  String? _email;
  String? _password;
  String? _adminType;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
User copyWith({  num? id,
  String? email,
  String? password,
  String? adminType,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
}) => User(  id: id ?? _id,
  email: email ?? _email,
  password: password ?? _password,
  adminType: adminType ?? _adminType,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  num? get id => _id;
  String? get email => _email;
  String? get password => _password;
  String? get adminType => _adminType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['password'] = _password;
    map['admin_type'] = _adminType;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    return map;
  }

}