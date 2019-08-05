import 'package:mix_cosmetics/beans/Data.dart';

class CountriesResponse {

  int status;
  String message;
  Data data;

	CountriesResponse.fromJsonMap(Map<String, dynamic> map): 
		status = map["status"],
		message = map["message"],
		data = Data.fromJsonMap(map["data"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status;
		data['message'] = message;
		data['data'] = data == null ? null : this.data.toJson();
		return data;
	}
}
