class QuestionsModel {
  final List<Question> questions;

  QuestionsModel({required this.questions});

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(
      questions: List<Question>.from(
        json['Questions'].map((question) => Question.fromJson(question)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Questions': questions.map((question) => question.toJson()).toList(),
    };
  }
}

class Question {
  final int id;
  final String title;
  final List<Mcq> mcqs;
  final int isShow;
  final int multiAnswer;
  final DateTime createdAt;

  Question({
    required this.id,
    required this.title,
    required this.mcqs,
    required this.isShow,
    required this.multiAnswer,
    required this.createdAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      mcqs: List<Mcq>.from(
        json['mcqs'].map((mcq) => Mcq.fromJson(mcq)),
      ),
      isShow: json['is_show'],
      multiAnswer: json['multi_answer'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'mcqs': mcqs.map((mcq) => mcq.toJson()).toList(),
      'is_show': isShow,
      'multi_answer': multiAnswer,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class Mcq {
  final Map<String, dynamic> options;

  Mcq({required this.options});

  factory Mcq.fromJson(Map<String, dynamic> json) {
    // Ensure dynamic mapping of key-value pairs
    return Mcq(
      options: Map<String, dynamic>.from(json),
    );
  }

  Map<String, dynamic> toJson() {
    return options;
  }
}
