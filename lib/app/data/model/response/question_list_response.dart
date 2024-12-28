import 'dart:convert';

/// question : [{"id":9,"is_show":true,"multi_answer":true,"is_input":false,"createdAt":"2024-12-24T11:30:06.207Z","updatedAt":"2024-12-24T11:30:06.207Z","deletedAt":"2024-12-24T11:30:06.207Z","QuestionLanguage":[{"id":27,"question_id":9,"language_type":"EN","title":"title","mcqs":[{"a":"a"},{"b":"b"}],"createdAt":"2024-12-24T11:30:06.207Z","updatedAt":"2024-12-24T11:30:06.207Z","deletedAt":"2024-12-24T11:30:06.207Z"}]},{"id":10,"is_show":true,"multi_answer":true,"is_input":false,"createdAt":"2024-12-24T11:36:06.044Z","updatedAt":"2024-12-24T11:36:06.044Z","deletedAt":"2024-12-24T11:30:06.207Z","QuestionLanguage":[{"id":28,"question_id":10,"language_type":"EN","title":"test 1","mcqs":[{"a":"test a"},{"b":"test b"},{"c":"test c"}],"createdAt":"2024-12-24T11:36:06.044Z","updatedAt":"2024-12-24T11:36:06.044Z","deletedAt":"2024-12-24T11:30:06.207Z"}]},{"id":11,"is_show":true,"multi_answer":false,"is_input":true,"createdAt":"2024-12-26T06:37:45.761Z","updatedAt":"2024-12-26T06:37:45.761Z","deletedAt":"2024-12-24T11:30:06.207Z","QuestionLanguage":[{"id":59,"question_id":11,"language_type":"EN","title":"test 2","mcqs":[{"a":"af"},{"b":"safa"},{"c":"asf"}],"createdAt":"2024-12-26T06:37:45.761Z","updatedAt":"2024-12-26T06:37:45.761Z","deletedAt":"2024-12-24T11:30:06.207Z"}]}]

QuestionListResponse questionListResponseFromJson(String str) =>
    QuestionListResponse.fromJson(json.decode(str));

String questionListResponseToJson(QuestionListResponse data) =>
    json.encode(data.toJson());

class QuestionListResponse {
  QuestionListResponse({
    List<Question>? question,
  }) {
    _question = question;
  }

  QuestionListResponse.fromJson(dynamic json) {
    if (json['question'] != null) {
      _question = [];
      json['question'].forEach((v) {
        _question?.add(Question.fromJson(v));
      });
    }
  }

  List<Question>? _question;

  QuestionListResponse copyWith({
    List<Question>? question,
  }) =>
      QuestionListResponse(
        question: question ?? _question,
      );

  List<Question>? get question => _question;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_question != null) {
      map['question'] = _question?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 9
/// is_show : true
/// multi_answer : true
/// is_input : false
/// createdAt : "2024-12-24T11:30:06.207Z"
/// updatedAt : "2024-12-24T11:30:06.207Z"
/// deletedAt : "2024-12-24T11:30:06.207Z"
/// QuestionLanguage : [{"id":27,"question_id":9,"language_type":"EN","title":"title","mcqs":[{"a":"a"},{"b":"b"}],"createdAt":"2024-12-24T11:30:06.207Z","updatedAt":"2024-12-24T11:30:06.207Z","deletedAt":"2024-12-24T11:30:06.207Z"}]

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  Question({
    num? id,
    bool? isShow,
    bool? multiAnswer,
    bool? isInput,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    List<QuestionLanguage>? questionLanguage,
  }) {
    _id = id;
    _isShow = isShow;
    _multiAnswer = multiAnswer;
    _isInput = isInput;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _questionLanguage = questionLanguage;
  }

  Question.fromJson(dynamic json) {
    _id = json['id'];
    _isShow = json['is_show'];
    _multiAnswer = json['multi_answer'];
    _isInput = json['is_input'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
    if (json['QuestionLanguage'] != null) {
      _questionLanguage = [];
      json['QuestionLanguage'].forEach((v) {
        _questionLanguage?.add(QuestionLanguage.fromJson(v));
      });
    }
  }

  num? _id;
  bool? _isShow;
  bool? _multiAnswer;
  bool? _isInput;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
  List<QuestionLanguage>? _questionLanguage;

  Question copyWith({
    num? id,
    bool? isShow,
    bool? multiAnswer,
    bool? isInput,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    List<QuestionLanguage>? questionLanguage,
  }) =>
      Question(
        id: id ?? _id,
        isShow: isShow ?? _isShow,
        multiAnswer: multiAnswer ?? _multiAnswer,
        isInput: isInput ?? _isInput,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
        questionLanguage: questionLanguage ?? _questionLanguage,
      );

  num? get id => _id;

  bool? get isShow => _isShow;

  bool? get multiAnswer => _multiAnswer;

  bool? get isInput => _isInput;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get deletedAt => _deletedAt;

  List<QuestionLanguage>? get questionLanguage => _questionLanguage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['is_show'] = _isShow;
    map['multi_answer'] = _multiAnswer;
    map['is_input'] = _isInput;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    if (_questionLanguage != null) {
      map['QuestionLanguage'] =
          _questionLanguage?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 27
/// question_id : 9
/// language_type : "EN"
/// title : "title"
/// mcqs : [{"a":"a"},{"b":"b"}]
/// createdAt : "2024-12-24T11:30:06.207Z"
/// updatedAt : "2024-12-24T11:30:06.207Z"
/// deletedAt : "2024-12-24T11:30:06.207Z"

QuestionLanguage questionLanguageFromJson(String str) =>
    QuestionLanguage.fromJson(json.decode(str));

String questionLanguageToJson(QuestionLanguage data) =>
    json.encode(data.toJson());

class QuestionLanguage {
  QuestionLanguage({
    num? id,
    num? questionId,
    String? languageType,
    String? title,
    List<Mcq>? mcqs,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    _id = id;
    _questionId = questionId;
    _languageType = languageType;
    _title = title;
    _mcqs = mcqs;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  QuestionLanguage.fromJson(dynamic json) {
    _id = json['id'];
    _questionId = json['question_id'];
    _languageType = json['language_type'];
    _title = json['title'];
    if (json['mcqs'] != null) {
      _mcqs = List<Mcq>.from(
        json['mcqs'].map((mcq) => Mcq.fromJson(mcq)),
      );
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
  }

  num? _id;
  num? _questionId;
  String? _languageType;
  String? _title;
  List<Mcq>? _mcqs;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;

  QuestionLanguage copyWith({
    num? id,
    num? questionId,
    String? languageType,
    String? title,
    List<Mcq>? mcqs,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) =>
      QuestionLanguage(
        id: id ?? _id,
        questionId: questionId ?? _questionId,
        languageType: languageType ?? _languageType,
        title: title ?? _title,
        mcqs: mcqs ?? _mcqs,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
      );

  num? get id => _id;

  num? get questionId => _questionId;

  String? get languageType => _languageType;

  String? get title => _title;

  List<Mcq>? get mcqs => _mcqs;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['question_id'] = _questionId;
    map['language_type'] = _languageType;
    map['title'] = _title;
    if (_mcqs != null) {
      map['mcqs'] = _mcqs?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    return map;
  }
}

/// a : "a"

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
