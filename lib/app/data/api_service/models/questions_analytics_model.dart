// To parse this JSON data, do
//
//     final questionsAnalytics = questionsAnalyticsFromJson(jsonString);

import 'dart:convert';

QuestionsAnalytics questionsAnalyticsFromJson(String str) => QuestionsAnalytics.fromJson(json.decode(str));

String questionsAnalyticsToJson(QuestionsAnalytics data) => json.encode(data.toJson());

class QuestionsAnalytics {
  List<Answer> answers;
  List<Analytics> analytics;
  String message;

  QuestionsAnalytics({
    required this.answers,
    required this.analytics,
    required this.message,
  });

  factory QuestionsAnalytics.fromJson(Map<String, dynamic> json) => QuestionsAnalytics(
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
    analytics: List<Analytics>.from(json["analytics"].map((x) => Analytics.fromJson(x))),
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
    "analytics": List<dynamic>.from(analytics.map((x) => x.toJson())),
    "Message": message,
  };
}

class Analytics {
  int count;
  String answer;
  double per;

  Analytics({
    required this.count,
    required this.answer,
    required this.per,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
    count: json["count"],
    answer: json["answer"],
    per: json["per"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "answer": answer,
    "per": per,
  };
}

class Answer {
  int id;
  int userId;
  int questionId;
  String mcq;
  DateTime createdAt;
  Users? users;

  Answer({
    required this.id,
    required this.userId,
    required this.questionId,
    required this.mcq,
    required this.createdAt,
    required this.users,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    id: json["id"],
    userId: json["user_id"],
    questionId: json["question_id"],
    mcq: json["mcq"],
    createdAt: DateTime.parse(json["created_at"]),
    users: json["users"] == null ? null : Users.fromJson(json["users"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "question_id": questionId,
    "mcq": mcq,
    "created_at": createdAt.toIso8601String(),
    "users": users?.toJson(),
  };
}

class Users {
  int id;
  String email;
  DateTime createdAt;

  Users({
    required this.id,
    required this.email,
    required this.createdAt,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    email: json["email"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "created_at": createdAt.toIso8601String(),
  };
}
