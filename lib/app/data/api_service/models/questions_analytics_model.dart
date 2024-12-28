import 'dart:convert';
/// totalMcqs : [{"mcqTitle":{"a":"Finding meaning and purpose in life"},"count":0},{"mcqTitle":{"b":"Managing depression or sadness"},"count":0},{"mcqTitle":{"c":"Managing anxiety and stress"},"count":0},{"mcqTitle":{"d":"Reducing overthinking and mental chatter"},"count":0},{"mcqTitle":{"e":"Personal development and self-discovery"},"count":0}]
/// totalUser : 0

QuestionsAnalyticsModel questionsAnalyticsModelFromJson(String str) => QuestionsAnalyticsModel.fromJson(json.decode(str));
String questionsAnalyticsModelToJson(QuestionsAnalyticsModel data) => json.encode(data.toJson());
class QuestionsAnalyticsModel {
  QuestionsAnalyticsModel({
      List<TotalMcqs>? totalMcqs, 
      num? totalUser,}){
    _totalMcqs = totalMcqs;
    _totalUser = totalUser;
}

  QuestionsAnalyticsModel.fromJson(dynamic json) {
    if (json['totalMcqs'] != null) {
      _totalMcqs = [];
      json['totalMcqs'].forEach((v) {
        _totalMcqs?.add(TotalMcqs.fromJson(v));
      });
    }
    _totalUser = json['totalUser'];
  }
  List<TotalMcqs>? _totalMcqs;
  num? _totalUser;
QuestionsAnalyticsModel copyWith({  List<TotalMcqs>? totalMcqs,
  num? totalUser,
}) => QuestionsAnalyticsModel(  totalMcqs: totalMcqs ?? _totalMcqs,
  totalUser: totalUser ?? _totalUser,
);
  List<TotalMcqs>? get totalMcqs => _totalMcqs;
  num? get totalUser => _totalUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_totalMcqs != null) {
      map['totalMcqs'] = _totalMcqs?.map((v) => v.toJson()).toList();
    }
    map['totalUser'] = _totalUser;
    return map;
  }

}

/// mcqTitle : {"a":"Finding meaning and purpose in life"}
/// count : 0

TotalMcqs totalMcqsFromJson(String str) => TotalMcqs.fromJson(json.decode(str));
String totalMcqsToJson(TotalMcqs data) => json.encode(data.toJson());
class TotalMcqs {
  TotalMcqs({
      McqTitle? mcqTitle, 
      num? count,}){
    _mcqTitle = mcqTitle;
    _count = count;
}

  TotalMcqs.fromJson(dynamic json) {
    _mcqTitle = json['mcqTitle'] != null ? McqTitle.fromJson(json['mcqTitle']) : null;
    _count = json['count'];
  }
  McqTitle? _mcqTitle;
  num? _count;
TotalMcqs copyWith({  McqTitle? mcqTitle,
  num? count,
}) => TotalMcqs(  mcqTitle: mcqTitle ?? _mcqTitle,
  count: count ?? _count,
);
  McqTitle? get mcqTitle => _mcqTitle;
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mcqTitle != null) {
      map['mcqTitle'] = _mcqTitle?.toJson();
    }
    map['count'] = _count;
    return map;
  }

}

/// a : "Finding meaning and purpose in life"

class McqTitle {
  final Map<String, String> options;

  McqTitle({required this.options});

  factory McqTitle.fromJson(Map<String, dynamic> json) {
    return McqTitle(
      options: Map<String, String>.from(json.map((key, value) => MapEntry(key, value.toString()))),
    );
  }

  Map<String, dynamic> toJson() {
    return options;
  }

  /// Get the first key in the options map
  String? get key => options.keys.isNotEmpty ? options.keys.first : null;

  /// Get the first value in the options map
  String? get value => options.values.isNotEmpty ? options.values.first : null;
}