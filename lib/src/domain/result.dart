import 'package:hackai/src/domain/fields.dart';
import 'package:hackai/src/domain/records.dart';
import 'package:hackai/src/domain/_links.dart';

class Result {

  bool include_total;
  String resource_id;
  List<Fields> fields;
  String records_format;
  List<Records> records;
	LLinks _links;
  int total;

	Result.fromJsonMap(Map<String, dynamic> map): 
		include_total = map["include_total"],
		resource_id = map["resource_id"],
		fields = List<Fields>.from(map["fields"].map((it) => Fields.fromJsonMap(it))),
		records_format = map["records_format"],
		records = List<Records>.from(map["records"].map((it) => Records.fromJsonMap(it))),
		_links = LLinks.fromJsonMap(map["_links"]),
		total = map["total"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['include_total'] = include_total;
		data['resource_id'] = resource_id;
		data['fields'] = fields != null ? 
			this.fields.map((v) => v.toJson()).toList()
			: null;
		data['records_format'] = records_format;
		data['records'] = records != null ? 
			this.records.map((v) => v.toJson()).toList()
			: null;
		data['_links'] = _links == null ? null : _links.toJson();
		data['total'] = total;
		return data;
	}
}
