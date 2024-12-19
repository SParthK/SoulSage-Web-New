
import 'dart:convert';

Credentials credentialsFromJson(String str) => Credentials.fromJson(json.decode(str));

String credentialsToJson(Credentials data) => json.encode(data.toJson());

class Credentials {
  bool success;
  Data data;

  Credentials({
    required this.success,
    required this.data,
  });

  factory Credentials.fromJson(Map<String, dynamic> json) => Credentials(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  String accessKeyId;
  String secretAccessKey;
  String region;
  String bucket;
  String acl;

  Data({
    required this.accessKeyId,
    required this.secretAccessKey,
    required this.region,
    required this.bucket,
    required this.acl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessKeyId: json["accessKeyId"],
    secretAccessKey: json["secretAccessKey"],
    region: json["region"],
    bucket: json["Bucket"],
    acl: json["ACL"],
  );

  Map<String, dynamic> toJson() => {
    "accessKeyId": accessKeyId,
    "secretAccessKey": secretAccessKey,
    "region": region,
    "Bucket": bucket,
    "ACL": acl,
  };
}
