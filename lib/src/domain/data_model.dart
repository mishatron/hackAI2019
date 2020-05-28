class DataModel {
  String userId;
  int color;
  double confidence;
  String text;
  String ukrText;
  double latitude;
  double longitude;
  int timestamp;

  DataModel();

  DataModel.fromJsonMap(Map<String, dynamic> map)
      : userId = map["userId"],
        color = map["color"],
        confidence = map["confidence"],
        text = map["text"],
        ukrText = map["ukrText"],
        latitude = map["latitude"],
        longitude = map["longitude"],
        timestamp = map["timestamp"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = userId;
    data['color'] = color;
    data['confidence'] = confidence;
    data['text'] = text;
    data['ukrText'] = ukrText;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['timestamp'] = timestamp;
    return data;
  }
}
