import 'dart:convert';

ImageUploadModel imageUploadModelFromJson(String str) => ImageUploadModel.fromJson(json.decode(str));

String imageUploadModelToJson(ImageUploadModel data) => json.encode(data.toJson());

class ImageUploadModel {
  bool success;
  Data data;

  ImageUploadModel({
    required this.success,
    required this.data,
  });

  factory ImageUploadModel.fromJson(Map<String, dynamic> json) => ImageUploadModel(
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
