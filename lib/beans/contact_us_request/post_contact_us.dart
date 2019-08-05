// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

ContactUsResponse postFromJson(String str) => ContactUsResponse.fromJson(json.decode(str));

String postToJson(ContactUsResponse data) => json.encode(data.toJson());

class ContactUsResponse {
  int status;
  String message;
  Data data;

  ContactUsResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) => new ContactUsResponse(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
