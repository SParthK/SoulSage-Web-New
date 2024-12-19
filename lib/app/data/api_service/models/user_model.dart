// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String token;
  User user;
  Subscription subscription;
  bool success;
  String message;

  UserModel({
    required this.token,
    required this.user,
    required this.subscription,
    required this.success,
    required this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        user: User.fromJson(json["user"]),
        subscription: Subscription.fromJson(json["subscription"] ?? {}),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
        "subscription": subscription.toJson(),
        "success": success,
        "message": message,
      };
}

class Subscription {
  int subscriptionId;
  String name;
  int price;
  int duration;
  DateTime createdAt;

  Subscription({
    required this.subscriptionId,
    required this.name,
    required this.price,
    required this.duration,
    required this.createdAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        subscriptionId: json["subscription_id"] ??0,
        name: json["name"] ?? '',
        price: json["price"] ?? 0,
        duration: json["duration"] ?? 0,
        createdAt: DateTime.parse(json["created_at"] ?? DateTime.now().toString()),
      );

  Map<String, dynamic> toJson() => {
        "subscription_id": subscriptionId,
        "name": name,
        "price": price,
        "duration": duration,
        "created_at": createdAt.toIso8601String(),
      };
}

class User {
  int id;
  String name;
  String email;
  String mobile;
  int emailVerified;
  dynamic emailVerifiedAt;
  int userType;
  String deviceType;
  String loginType;
  String profilePic;
  String country;
  int currentSubscription;
  int isActive;
  DateTime lastActiveAt;
  DateTime createdAt;
  DateTime updatedAt;
  bool isadmin;

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
    required this.currentSubscription,
    required this.isActive,
    required this.lastActiveAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isadmin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        emailVerified: json["email_verified"],
        emailVerifiedAt: json["email_verified_at"],
        userType: json["user_type"],
        deviceType: json["device_type"],
        loginType: json["login_type"],
        profilePic: json["profile_pic"],
        country: json["country"],
        currentSubscription: json["current_subscription"],
        isActive: json["is_active"],
        lastActiveAt: DateTime.parse(json["last_active_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isadmin: json["isadmin"],
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
        "current_subscription": currentSubscription,
        "is_active": isActive,
        "last_active_at": lastActiveAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "isadmin": isadmin,
      };
}
