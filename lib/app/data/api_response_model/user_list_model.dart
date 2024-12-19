// To parse this JSON data, do
//
//     final userList = userListFromJson(jsonString);

import 'dart:convert';

UserList userListFromJson(String str) => UserList.fromJson(json.decode(str));

String userListToJson(UserList data) => json.encode(data.toJson());

class UserList {
  List<User> users;

  UserList({
    required this.users,
  });

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class User {
  int id;
  String name;
  String email;
  dynamic mobile;
  int emailVerified;
  dynamic emailVerifiedAt;
  int userType;
  String deviceType;
  String loginType;
  String profilePic;
  String country;
  String fcmToken;
  int currentSubscription;
  int isActive;
  int onboarding;
  int chapterAccess;
  DateTime lastActiveAt;
  DateTime createdAt;
  DateTime updatedAt;
  int maxChapter;
  int maxModule;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.emailVerified,
    required this.emailVerifiedAt,
    required this.userType,
    required this.deviceType,
    required this.loginType,
    required this.profilePic,
    required this.country,
    required this.fcmToken,
    required this.currentSubscription,
    required this.isActive,
    required this.onboarding,
    required this.chapterAccess,
    required this.lastActiveAt,
    required this.createdAt,
    required this.updatedAt,
    required this.maxChapter,
    required this.maxModule,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        mobile: json["mobile"] ?? "",
        emailVerified: json["email_verified"] ?? 0,
        emailVerifiedAt: json["email_verified_at"] ?? DateTime.now().toString(),
        userType: json["user_type"] ?? 0,
        deviceType: json["device_type"] ?? "",
        loginType: json["login_type"] ?? "",
        profilePic: json["profile_pic"] ?? "",
        country: json["country"] ?? "",
        fcmToken: json["fcm_token"] ?? "",
        currentSubscription: json["current_subscription"] ?? 0,
        isActive: json["is_active"] ?? 0,
        onboarding: json["onboarding"] ?? 0,
        chapterAccess: json["chapter_access"] ?? 0,
        lastActiveAt:
            DateTime.parse(json["last_active_at"] ?? DateTime.now().toString()),
        createdAt:
            DateTime.parse(json["created_at"] ?? DateTime.now().toString()),
        updatedAt:
            DateTime.parse(json["updated_at"] ?? DateTime.now().toString()),
        maxChapter: json["max_chapter"] ?? 0,
        maxModule: json["max_module"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "email_verified": emailVerified,
        "email_verified_at": emailVerifiedAt,
        "user_type": userType,
        "device_type": deviceType,
        "login_type": loginType,
        "profile_pic": profilePic,
        "country": country,
        "fcm_token": fcmToken,
        "current_subscription": currentSubscription,
        "is_active": isActive,
        "onboarding": onboarding,
        "chapter_access": chapterAccess,
        "last_active_at": lastActiveAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "max_chapter": maxChapter,
        "max_module": maxModule,
      };
}
