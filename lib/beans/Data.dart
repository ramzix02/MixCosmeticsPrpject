import 'Countries.dart';

class Data {

  List<Country> countries;

	Data.fromJsonMap(Map<String, dynamic> map): 
		countries = List<Country>.from(map["countries"].map((it) => Country.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['countries'] = countries != null ? 
			this.countries.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
