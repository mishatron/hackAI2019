import 'package:hackai/src/domain/result.dart';

class AdModel {

  String help;
  bool success;
  Result result;

	AdModel.fromJsonMap(Map<String, dynamic> map): 
		help = map["help"],
		success = map["success"],
		result = Result.fromJsonMap(map["result"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['help'] = help;
		data['success'] = success;
		data['result'] = result == null ? null : result.toJson();
		return data;
	}
}
