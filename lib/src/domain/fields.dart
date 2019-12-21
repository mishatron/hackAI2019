
class Fields {

  String type;
  String id;

	Fields.fromJsonMap(Map<String, dynamic> map): 
		type = map["type"],
		id = map["id"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['type'] = type;
		data['id'] = id;
		return data;
	}
}
