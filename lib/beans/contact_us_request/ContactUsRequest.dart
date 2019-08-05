
class ContactUsRequest {

  String username , email , phone , message ;

  ContactUsRequest(this.username, this.email ,this.phone , this.message);

  ContactUsRequest.fromJsonMap(Map<String, dynamic> map):
        username = map["name"],
        email = map["email"],
        phone     = map["phone"],
        message    = map["message"];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = username;
    data['email'] = email;
    data["phone"] = phone;
    data['message'] = message;

    return data;
  }
}
