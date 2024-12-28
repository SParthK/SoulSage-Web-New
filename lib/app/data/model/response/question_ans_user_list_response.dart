import 'dart:convert';
/// userAnswers : [{"id":1,"user_id":1176,"question_id":37,"mcqs":"a, b","input":null,"createdAt":"2024-12-28T08:53:25.561Z","updatedAt":"2024-12-28T08:53:25.561Z","deletedAt":null,"User":{"id":1176,"email":"shingalaparth02@gmail.com","name":"Parth Parth","mobile":"NA","email_verified":true,"email_verified_at":null,"device_type":"Android","login_type":"Google","country":"United Kingdom of Great Britain and Northern Ireland","fcm_token":"eJH5BWEHTReFQQMSJX7gtS:APA91bEKKr3zy2iT0r21S_CLFg5_FL9k2yTMlk5znrF-3qj621JD_SjGzmbCxOjP-PcHzwCVd_XBOwMt0jHWZBfScU-Reqx3q0dUwZNyqZwZDKcP4DKTJgQ","current_subscription":false,"otp":null,"is_active":true,"onboarding":true,"chapter_access":false,"last_active_at":"2024-12-28T08:53:21.090Z","remember_token":null,"createdAt":"2024-12-28T08:53:21.378Z","updatedAt":"2024-12-28T08:54:04.926Z","deletedAt":null}}]
/// total : 0
/// totalPage : 0
/// page : 1
/// limit : 10

QuestionAnsUserListResponse questionAnsUserListResponseFromJson(String str) => QuestionAnsUserListResponse.fromJson(json.decode(str));
String questionAnsUserListResponseToJson(QuestionAnsUserListResponse data) => json.encode(data.toJson());
class QuestionAnsUserListResponse {
  QuestionAnsUserListResponse({
      List<UserAnswers>? userAnswers, 
      num? total, 
      num? totalPage, 
      num? page, 
      num? limit,}){
    _userAnswers = userAnswers;
    _total = total;
    _totalPage = totalPage;
    _page = page;
    _limit = limit;
}

  QuestionAnsUserListResponse.fromJson(dynamic json) {
    if (json['userAnswers'] != null) {
      _userAnswers = [];
      json['userAnswers'].forEach((v) {
        _userAnswers?.add(UserAnswers.fromJson(v));
      });
    }
    _total = json['total'];
    _totalPage = json['totalPage'];
    _page = json['page'];
    _limit = json['limit'];
  }
  List<UserAnswers>? _userAnswers;
  num? _total;
  num? _totalPage;
  num? _page;
  num? _limit;
QuestionAnsUserListResponse copyWith({  List<UserAnswers>? userAnswers,
  num? total,
  num? totalPage,
  num? page,
  num? limit,
}) => QuestionAnsUserListResponse(  userAnswers: userAnswers ?? _userAnswers,
  total: total ?? _total,
  totalPage: totalPage ?? _totalPage,
  page: page ?? _page,
  limit: limit ?? _limit,
);
  List<UserAnswers>? get userAnswers => _userAnswers;
  num? get total => _total;
  num? get totalPage => _totalPage;
  num? get page => _page;
  num? get limit => _limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_userAnswers != null) {
      map['userAnswers'] = _userAnswers?.map((v) => v.toJson()).toList();
    }
    map['total'] = _total;
    map['totalPage'] = _totalPage;
    map['page'] = _page;
    map['limit'] = _limit;
    return map;
  }

}

/// id : 1
/// user_id : 1176
/// question_id : 37
/// mcqs : "a, b"
/// input : null
/// createdAt : "2024-12-28T08:53:25.561Z"
/// updatedAt : "2024-12-28T08:53:25.561Z"
/// deletedAt : null
/// User : {"id":1176,"email":"shingalaparth02@gmail.com","name":"Parth Parth","mobile":"NA","email_verified":true,"email_verified_at":null,"device_type":"Android","login_type":"Google","country":"United Kingdom of Great Britain and Northern Ireland","fcm_token":"eJH5BWEHTReFQQMSJX7gtS:APA91bEKKr3zy2iT0r21S_CLFg5_FL9k2yTMlk5znrF-3qj621JD_SjGzmbCxOjP-PcHzwCVd_XBOwMt0jHWZBfScU-Reqx3q0dUwZNyqZwZDKcP4DKTJgQ","current_subscription":false,"otp":null,"is_active":true,"onboarding":true,"chapter_access":false,"last_active_at":"2024-12-28T08:53:21.090Z","remember_token":null,"createdAt":"2024-12-28T08:53:21.378Z","updatedAt":"2024-12-28T08:54:04.926Z","deletedAt":null}

UserAnswers userAnswersFromJson(String str) => UserAnswers.fromJson(json.decode(str));
String userAnswersToJson(UserAnswers data) => json.encode(data.toJson());
class UserAnswers {
  UserAnswers({
      num? id, 
      num? userId, 
      num? questionId, 
      String? mcqs, 
      dynamic input, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      User? user,}){
    _id = id;
    _userId = userId;
    _questionId = questionId;
    _mcqs = mcqs;
    _input = input;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _user = user;
}

  UserAnswers.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _questionId = json['question_id'];
    _mcqs = json['mcqs'];
    _input = json['input'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
    _user = json['User'] != null ? User.fromJson(json['User']) : null;
  }
  num? _id;
  num? _userId;
  num? _questionId;
  String? _mcqs;
  dynamic _input;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  User? _user;
UserAnswers copyWith({  num? id,
  num? userId,
  num? questionId,
  String? mcqs,
  dynamic input,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  User? user,
}) => UserAnswers(  id: id ?? _id,
  userId: userId ?? _userId,
  questionId: questionId ?? _questionId,
  mcqs: mcqs ?? _mcqs,
  input: input ?? _input,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  user: user ?? _user,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get questionId => _questionId;
  String? get mcqs => _mcqs;
  dynamic get input => _input;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['question_id'] = _questionId;
    map['mcqs'] = _mcqs;
    map['input'] = _input;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    if (_user != null) {
      map['User'] = _user?.toJson();
    }
    return map;
  }

}

/// id : 1176
/// email : "shingalaparth02@gmail.com"
/// name : "Parth Parth"
/// mobile : "NA"
/// email_verified : true
/// email_verified_at : null
/// device_type : "Android"
/// login_type : "Google"
/// country : "United Kingdom of Great Britain and Northern Ireland"
/// fcm_token : "eJH5BWEHTReFQQMSJX7gtS:APA91bEKKr3zy2iT0r21S_CLFg5_FL9k2yTMlk5znrF-3qj621JD_SjGzmbCxOjP-PcHzwCVd_XBOwMt0jHWZBfScU-Reqx3q0dUwZNyqZwZDKcP4DKTJgQ"
/// current_subscription : false
/// otp : null
/// is_active : true
/// onboarding : true
/// chapter_access : false
/// last_active_at : "2024-12-28T08:53:21.090Z"
/// remember_token : null
/// createdAt : "2024-12-28T08:53:21.378Z"
/// updatedAt : "2024-12-28T08:54:04.926Z"
/// deletedAt : null

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      num? id, 
      String? email, 
      String? name, 
      String? mobile, 
      bool? emailVerified, 
      dynamic emailVerifiedAt, 
      String? deviceType, 
      String? loginType, 
      String? country, 
      String? fcmToken, 
      bool? currentSubscription, 
      dynamic otp, 
      bool? isActive, 
      bool? onboarding, 
      bool? chapterAccess, 
      String? lastActiveAt, 
      dynamic rememberToken, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt,}){
    _id = id;
    _email = email;
    _name = name;
    _mobile = mobile;
    _emailVerified = emailVerified;
    _emailVerifiedAt = emailVerifiedAt;
    _deviceType = deviceType;
    _loginType = loginType;
    _country = country;
    _fcmToken = fcmToken;
    _currentSubscription = currentSubscription;
    _otp = otp;
    _isActive = isActive;
    _onboarding = onboarding;
    _chapterAccess = chapterAccess;
    _lastActiveAt = lastActiveAt;
    _rememberToken = rememberToken;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _name = json['name'];
    _mobile = json['mobile'];
    _emailVerified = json['email_verified'];
    _emailVerifiedAt = json['email_verified_at'];
    _deviceType = json['device_type'];
    _loginType = json['login_type'];
    _country = json['country'];
    _fcmToken = json['fcm_token'];
    _currentSubscription = json['current_subscription'];
    _otp = json['otp'];
    _isActive = json['is_active'];
    _onboarding = json['onboarding'];
    _chapterAccess = json['chapter_access'];
    _lastActiveAt = json['last_active_at'];
    _rememberToken = json['remember_token'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
  }
  num? _id;
  String? _email;
  String? _name;
  String? _mobile;
  bool? _emailVerified;
  dynamic _emailVerifiedAt;
  String? _deviceType;
  String? _loginType;
  String? _country;
  String? _fcmToken;
  bool? _currentSubscription;
  dynamic _otp;
  bool? _isActive;
  bool? _onboarding;
  bool? _chapterAccess;
  String? _lastActiveAt;
  dynamic _rememberToken;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
User copyWith({  num? id,
  String? email,
  String? name,
  String? mobile,
  bool? emailVerified,
  dynamic emailVerifiedAt,
  String? deviceType,
  String? loginType,
  String? country,
  String? fcmToken,
  bool? currentSubscription,
  dynamic otp,
  bool? isActive,
  bool? onboarding,
  bool? chapterAccess,
  String? lastActiveAt,
  dynamic rememberToken,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
}) => User(  id: id ?? _id,
  email: email ?? _email,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  emailVerified: emailVerified ?? _emailVerified,
  emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
  deviceType: deviceType ?? _deviceType,
  loginType: loginType ?? _loginType,
  country: country ?? _country,
  fcmToken: fcmToken ?? _fcmToken,
  currentSubscription: currentSubscription ?? _currentSubscription,
  otp: otp ?? _otp,
  isActive: isActive ?? _isActive,
  onboarding: onboarding ?? _onboarding,
  chapterAccess: chapterAccess ?? _chapterAccess,
  lastActiveAt: lastActiveAt ?? _lastActiveAt,
  rememberToken: rememberToken ?? _rememberToken,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  num? get id => _id;
  String? get email => _email;
  String? get name => _name;
  String? get mobile => _mobile;
  bool? get emailVerified => _emailVerified;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String? get deviceType => _deviceType;
  String? get loginType => _loginType;
  String? get country => _country;
  String? get fcmToken => _fcmToken;
  bool? get currentSubscription => _currentSubscription;
  dynamic get otp => _otp;
  bool? get isActive => _isActive;
  bool? get onboarding => _onboarding;
  bool? get chapterAccess => _chapterAccess;
  String? get lastActiveAt => _lastActiveAt;
  dynamic get rememberToken => _rememberToken;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['email_verified'] = _emailVerified;
    map['email_verified_at'] = _emailVerifiedAt;
    map['device_type'] = _deviceType;
    map['login_type'] = _loginType;
    map['country'] = _country;
    map['fcm_token'] = _fcmToken;
    map['current_subscription'] = _currentSubscription;
    map['otp'] = _otp;
    map['is_active'] = _isActive;
    map['onboarding'] = _onboarding;
    map['chapter_access'] = _chapterAccess;
    map['last_active_at'] = _lastActiveAt;
    map['remember_token'] = _rememberToken;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    return map;
  }

}