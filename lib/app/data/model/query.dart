/// _id : "asfhc98sdfca98fah"

class Query {
  Query({
    String? id,
  }) {
    _id = id;
  }

  Query.fromJson(dynamic json) {
    _id = json['_id'];
  }

  String? _id;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    return map;
  }
}
