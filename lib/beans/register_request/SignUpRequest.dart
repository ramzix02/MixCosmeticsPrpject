
class SignUpRequest {

  String username , password , name , email , phone,countryID;

  SignUpRequest(this.username, this.password ,this.name,this.email,this.phone  ,this.countryID);

  SignUpRequest.fromJsonMap(Map<String, dynamic> map):
        username = map["username"],
        password = map["password"],
        name     = map["name"],
        email    = map["email"],
        phone    = map["phone"],
        countryID= map["country_id"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data['password'] = password;
    data["name"] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['country_id'] = countryID;
    return data;
  }
}
