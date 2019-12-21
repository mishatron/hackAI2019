
class LLinks {

  String start;
  String next;

	LLinks.fromJsonMap(Map<String, dynamic> map):
		start = map["start"],
		next = map["next"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['start'] = start;
		data['next'] = next;
		return data;
	}
}
