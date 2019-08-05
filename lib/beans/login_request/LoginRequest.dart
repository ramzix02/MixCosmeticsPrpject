
class LoginRequest {

  String username;
  String password;


	LoginRequest(this.username, this.password);

	LoginRequest.fromJsonMap(Map<String, dynamic> map):
		username = map["username"],
		password = map["password"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['username'] = username;
		data['password'] = password;
		return data;
	}
}
