import 'dart:convert';
/// userList : [{"id":38,"email":"nandanwarnakul@gmail.com","name":"ChalJaneDe","mobile":null,"email_verified":true,"email_verified_at":null,"device_type":"Android","login_type":"Google","country":"India","fcm_token":"crHfWlhRSDaR9rd4tsB0yo:APA91bHTn0_SIEwt-5PiXcgpc2s76kQpnpdZ35zJNWorOOTq244QSvOouwXns4shkdien8SP6eyAAQPf7wHOE7McS3P7zaYr3DGms_-LNH50XQ0V6J6Edu8","current_subscription":true,"otp":0,"is_active":true,"onboarding":true,"chapter_access":true,"last_active_at":"2024-12-07T00:39:47.000Z","remember_token":null,"createdAt":"2024-10-23T19:48:02.000Z","updatedAt":"2024-12-28T06:46:55.107Z","deletedAt":null,"current_module":205,"current_chapter":45},{"id":40,"email":"frootinarwane14@gmail.com","name":"Frooti Narwane","mobile":null,"email_verified":true,"email_verified_at":null,"device_type":"Android","login_type":"Google","country":"India","fcm_token":"fgljEPdMTPKnEedmCMWE1B:APA91bG9ySpBjq-7Yg_bxXhhJoLsLIX9QTwJBvmJMEkPwVUjibHSIyOFWpFgfZkCTynEX8--lR8lNRAt6u_gzBdw2_nbNw93JbR_WGlMa_b-cpADEgfLcaybxPBuir3qmYL92vTSRnT8","current_subscription":false,"otp":0,"is_active":true,"onboarding":true,"chapter_access":false,"last_active_at":"2024-10-23T21:12:45.000Z","remember_token":null,"createdAt":"2024-10-23T21:10:37.000Z","updatedAt":"2024-12-26T13:58:48.528Z","deletedAt":null,"current_module":205,"current_chapter":45},{"id":41,"email":"sarkarsudip1313@gmail.com","name":"Sudip Sarkar","mobile":null,"email_verified":true,"email_verified_at":null,"device_type":"Android","login_type":"Google","country":"India","fcm_token":"f7Jj4Fa8TW67whVAXsx1VV:APA91bGXuD1w6fH-hhnU2Rksnbf818Lex545C0Bsca0tG4tIARpOK7lq7104gi4wv6L37Csxz7k-AmxR4BxNAPiItORti9Gpi2fl6QX1fflCK9VpNhTLOybsAwi4zKMEgU4_7TOyM-vx","current_subscription":false,"otp":0,"is_active":true,"onboarding":true,"chapter_access":false,"last_active_at":"2024-11-06T15:21:10.000Z","remember_token":null,"createdAt":"2024-10-24T12:18:43.000Z","updatedAt":"2024-12-26T13:58:48.528Z","deletedAt":null,"current_module":205,"current_chapter":45},{"id":42,"email":"nakulnandanwar@gmail.com","name":"SoulSage user","mobile":null,"email_verified":true,"email_verified_at":null,"device_type":"Android","login_type":"Google","country":"India","fcm_token":"crHfWlhRSDaR9rd4tsB0yo:APA91bHTn0_SIEwt-5PiXcgpc2s76kQpnpdZ35zJNWorOOTq244QSvOouwXns4shkdien8SP6eyAAQPf7wHOE7McS3P7zaYr3DGms_-LNH50XQ0V6J6Edu8","current_subscription":false,"otp":0,"is_active":false,"onboarding":true,"chapter_access":false,"last_active_at":"2024-11-25T17:34:28.000Z","remember_token":"566rxjuBlEqs0N11Uwdb","createdAt":"2024-10-24T21:35:20.000Z","updatedAt":"2024-12-26T13:58:48.528Z","deletedAt":null,"current_module":205,"current_chapter":45},{"id":45,"email":"sinit.tst@gmail.com","name":"SoulSage user","mobile":null,"email_verified":true,"email_verified_at":null,"device_type":"Android","login_type":"Google","country":"India","fcm_token":"dedatqSzSpuC2HpDAuR4Lc:APA91bFLFCIKJ8M9TH87J3PbL3uDYiM10VUNf7X9HJG0h7WGKGXot8ZQ-t89Vyvoide1qLpDe4TjTSu94CDSFADLV3-Q-Jnqdu9RhGQjHl1eI8G0NrR7410","current_subscription":false,"otp":0,"is_active":true,"onboarding":true,"chapter_access":false,"last_active_at":"2024-11-15T10:24:37.000Z","remember_token":null,"createdAt":"2024-10-28T20:15:35.000Z","updatedAt":"2024-12-26T13:58:48.528Z","deletedAt":null,"current_module":205,"current_chapter":45},{"id":47,"email":"speed007v@gmail.com","name":"vaibhav nandanwar","mobile":null,"email_verified":true,"email_verified_at":null,"device_type":"Android","login_type":"Google","country":"India","fcm_token":"f20eRS97Sz263MWUd_WgNl:APA91bHWIFG7mo6oul-SPlXlnpXX8kZRvVZyBsPz2Ly9s0SG2WjMr3Y8U3x1fT2nIGry3wFtWsNmCD__XSCuTyVU132izXwomIhAoXwA7UquhLtnJXj0A_8","current_subscription":false,"otp":0,"is_active":true,"onboarding":true,"chapter_access":false,"last_active_at":"2024-11-20T14:25:58.000Z","remember_token":null,"createdAt":"2024-11-10T17:41:00.000Z","updatedAt":"2024-12-26T13:58:48.528Z","deletedAt":null,"current_module":205,"current_chapter":45},{"id":48,"email":"speed007a@gmail.com","name":"Vaibhav Nandanwar","mobile":null,"email_verified":true,"email_verified_at":null,"device_type":"Android","login_type":"Google","country":"India","fcm_token":"dXac2YHWQouvqG4EcyImYH:APA91bG-SX_iu9wFdtmTdjxuGMquNJphbOc0mO_c3fucSPdbtgw4lwlEYi1Z2s7b1hxx5I0Lk8FukuTgv9xSwnEcpfQwKV5bP_qzR_yW4brxwH1prtxgRvU","current_subscription":false,"otp":0,"is_active":true,"onboarding":true,"chapter_access":false,"last_active_at":"2024-11-21T08:20:30.000Z","remember_token":null,"createdAt":"2024-11-13T10:33:57.000Z","updatedAt":"2024-12-26T13:58:48.528Z","deletedAt":null,"current_module":205,"current_chapter":45},{"id":49,"email":"concentrixwave46batch2@gmail.com","name":"Concentrixwave46batch2","mobile":null,"email_verified":true,"email_verified_at":null,"device_type":"Android","login_type":"Google","country":"India","fcm_token":"c09RjqY_SlmapvR7ekCTxw:APA91bGF1BlFkbXRhApyddX_MUs0GcSNJ75pomBz2_298LPA2xcYi80QwL7QKsQ6O5-SdB41qiw5WLKJ8Nfr4KcO8ARVvGbe7ywjp4avMABGpiayFYeOHY0","current_subscription":false,"otp":0,"is_active":true,"onboarding":true,"chapter_access":false,"last_active_at":"2024-11-14T20:41:29.000Z","remember_token":null,"createdAt":"2024-11-14T17:46:47.000Z","updatedAt":"2024-12-26T13:58:48.528Z","deletedAt":null,"current_module":205,"current_chapter":45},{"id":50,"email":"rshitole93@gmail.com","name":"Rahul Shitole","mobile":null,"email_verified":true,"email_verified_at":null,"device_type":"Android","login_type":"Google","country":"India","fcm_token":"fAhZvcQRS0OVtJieCz6ILL:APA91bF-IKmXZM8iUEyaiLeDXMCH4-OiqKCopUeq69gY4I9SoiqG8dOVvZzlFGiyJSpYPEeNVo79DHCpt6zQuddZnwub33qI_zbXw0CUbyRIsnzyogSJghE","current_subscription":false,"otp":779304,"is_active":true,"onboarding":true,"chapter_access":false,"last_active_at":"2024-12-01T21:16:03.000Z","remember_token":null,"createdAt":"2024-11-15T17:24:39.000Z","updatedAt":"2024-12-26T13:58:48.528Z","deletedAt":null,"current_module":205,"current_chapter":45},{"id":51,"email":"nishitanandanwar@gmail.com","name":"Nishita Nandanwar","mobile":null,"email_verified":true,"email_verified_at":null,"device_type":"Android","login_type":"Google","country":"India","fcm_token":"cOEUvvabRZ6Wihybh0W5rz:APA91bEc_4YP91NOm79uQtJG1IVFyyOPhwc4vD9dMKEz6cjWyu04S-tv10Mk4x3E8LEdjBJ4hNkXqHcCvjqL_yOtC0SJG_PjXFcAWvHqUh9_ApmiNyNpHgo","current_subscription":false,"otp":0,"is_active":true,"onboarding":true,"chapter_access":false,"last_active_at":"2024-11-16T10:33:28.000Z","remember_token":null,"createdAt":"2024-11-16T10:33:25.000Z","updatedAt":"2024-12-26T13:58:48.528Z","deletedAt":null,"current_module":205,"current_chapter":45}]
/// metaData : {"total":380,"totalPage":38,"page":1,"limit":10}

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));
String userResponseToJson(UserResponse data) => json.encode(data.toJson());
class UserResponse {
  UserResponse({
      List<UserList>? userList, 
      MetaData? metaData,}){
    _userList = userList;
    _metaData = metaData;
}

  UserResponse.fromJson(dynamic json) {
    if (json['userList'] != null) {
      _userList = [];
      json['userList'].forEach((v) {
        _userList?.add(UserList.fromJson(v));
      });
    }
    _metaData = json['metaData'] != null ? MetaData.fromJson(json['metaData']) : null;
  }
  List<UserList>? _userList;
  MetaData? _metaData;
UserResponse copyWith({  List<UserList>? userList,
  MetaData? metaData,
}) => UserResponse(  userList: userList ?? _userList,
  metaData: metaData ?? _metaData,
);
  List<UserList>? get userList => _userList;
  MetaData? get metaData => _metaData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_userList != null) {
      map['userList'] = _userList?.map((v) => v.toJson()).toList();
    }
    if (_metaData != null) {
      map['metaData'] = _metaData?.toJson();
    }
    return map;
  }

}

/// total : 380
/// totalPage : 38
/// page : 1
/// limit : 10

MetaData metaDataFromJson(String str) => MetaData.fromJson(json.decode(str));
String metaDataToJson(MetaData data) => json.encode(data.toJson());
class MetaData {
  MetaData({
      num? total, 
      num? totalPage, 
      num? page, 
      num? limit,}){
    _total = total;
    _totalPage = totalPage;
    _page = page;
    _limit = limit;
}

  MetaData.fromJson(dynamic json) {
    _total = json['total'];
    _totalPage = json['totalPage'];
    _page = json['page'];
    _limit = json['limit'];
  }
  num? _total;
  num? _totalPage;
  num? _page;
  num? _limit;
MetaData copyWith({  num? total,
  num? totalPage,
  num? page,
  num? limit,
}) => MetaData(  total: total ?? _total,
  totalPage: totalPage ?? _totalPage,
  page: page ?? _page,
  limit: limit ?? _limit,
);
  num? get total => _total;
  num? get totalPage => _totalPage;
  num? get page => _page;
  num? get limit => _limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['totalPage'] = _totalPage;
    map['page'] = _page;
    map['limit'] = _limit;
    return map;
  }

}

/// id : 38
/// email : "nandanwarnakul@gmail.com"
/// name : "ChalJaneDe"
/// mobile : null
/// email_verified : true
/// email_verified_at : null
/// device_type : "Android"
/// login_type : "Google"
/// country : "India"
/// fcm_token : "crHfWlhRSDaR9rd4tsB0yo:APA91bHTn0_SIEwt-5PiXcgpc2s76kQpnpdZ35zJNWorOOTq244QSvOouwXns4shkdien8SP6eyAAQPf7wHOE7McS3P7zaYr3DGms_-LNH50XQ0V6J6Edu8"
/// current_subscription : true
/// otp : 0
/// is_active : true
/// onboarding : true
/// chapter_access : true
/// last_active_at : "2024-12-07T00:39:47.000Z"
/// remember_token : null
/// createdAt : "2024-10-23T19:48:02.000Z"
/// updatedAt : "2024-12-28T06:46:55.107Z"
/// deletedAt : null
/// current_module : 205
/// current_chapter : 45

UserList userListFromJson(String str) => UserList.fromJson(json.decode(str));
String userListToJson(UserList data) => json.encode(data.toJson());
class UserList {
  UserList({
      num? id, 
      String? email, 
      String? name, 
      dynamic mobile, 
      bool? emailVerified, 
      dynamic emailVerifiedAt, 
      String? deviceType, 
      String? loginType, 
      String? country, 
      String? fcmToken, 
      bool? currentSubscription, 
      num? otp, 
      bool? isActive, 
      bool? onboarding, 
      bool? chapterAccess, 
      String? lastActiveAt, 
      dynamic rememberToken, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      num? currentModule, 
      num? currentChapter,}){
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
    _currentModule = currentModule;
    _currentChapter = currentChapter;
}

  UserList.fromJson(dynamic json) {
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
    _currentModule = json['current_module'];
    _currentChapter = json['current_chapter'];
  }
  num? _id;
  String? _email;
  String? _name;
  dynamic _mobile;
  bool? _emailVerified;
  dynamic _emailVerifiedAt;
  String? _deviceType;
  String? _loginType;
  String? _country;
  String? _fcmToken;
  bool? _currentSubscription;
  num? _otp;
  bool? _isActive;
  bool? _onboarding;
  bool? _chapterAccess;
  String? _lastActiveAt;
  dynamic _rememberToken;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  num? _currentModule;
  num? _currentChapter;
UserList copyWith({  num? id,
  String? email,
  String? name,
  dynamic mobile,
  bool? emailVerified,
  dynamic emailVerifiedAt,
  String? deviceType,
  String? loginType,
  String? country,
  String? fcmToken,
  bool? currentSubscription,
  num? otp,
  bool? isActive,
  bool? onboarding,
  bool? chapterAccess,
  String? lastActiveAt,
  dynamic rememberToken,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  num? currentModule,
  num? currentChapter,
}) => UserList(  id: id ?? _id,
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
  currentModule: currentModule ?? _currentModule,
  currentChapter: currentChapter ?? _currentChapter,
);
  num? get id => _id;
  String? get email => _email;
  String? get name => _name;
  dynamic get mobile => _mobile;
  bool? get emailVerified => _emailVerified;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String? get deviceType => _deviceType;
  String? get loginType => _loginType;
  String? get country => _country;
  String? get fcmToken => _fcmToken;
  bool? get currentSubscription => _currentSubscription;
  num? get otp => _otp;
  bool? get isActive => _isActive;
  bool? get onboarding => _onboarding;
  bool? get chapterAccess => _chapterAccess;
  String? get lastActiveAt => _lastActiveAt;
  dynamic get rememberToken => _rememberToken;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  num? get currentModule => _currentModule;
  num? get currentChapter => _currentChapter;

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
    map['current_module'] = _currentModule;
    map['current_chapter'] = _currentChapter;
    return map;
  }

}