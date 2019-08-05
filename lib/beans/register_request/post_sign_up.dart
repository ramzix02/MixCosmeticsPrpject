// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

SignUpResponse postFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String postToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  Status status;
  Result result;

  SignUpResponse({
    this.status,
    this.result,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => new SignUpResponse(
    status: Status.fromJson(json["Status"]),
    result: Result.fromJson(json["Result"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status.toJson(),
    "Result": result.toJson(),
  };
}

class Result {
  User user;

  Result({
    this.user,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
  int id;
  String name;
  String username;
  String email;
  String phone;
  int countryId;
  String authorization;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.countryId,
    this.authorization,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    countryId: json["country_id"],
    authorization: json["authorization"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "email": email,
    "phone": phone,
    "country_id": countryId,
    "authorization": authorization,
  };
  @override
  String toString() {
    return "{"
        "id: $id, "
        "name: $name, "
        "username: $username,"
        "email: $email,"
        "phone: $phone,"
        "country_id: $countryId,"
        "authorization: $authorization"
        "}";
  }
}

class Status {
  int succeed;
  String message;

  Status({
    this.succeed,
    this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) => new Status(
    succeed: json["Succeed"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "Succeed": succeed,
    "message": message,
  };
}
