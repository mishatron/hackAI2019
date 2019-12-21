class ClientModel {
  String id;
  String name;
  String surname;
  String email;
  String phone;
  String photoUrl;

  ClientModel({this.id, this.name, this.surname, this.email, this.phone, this.photoUrl});

  ClientModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    surname = json['Surname'];
    email = json['Email'];
    phone = json['Phone'];
    photoUrl = json['PhotoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Surname'] = this.surname;
    data['Email'] = this.email;
    data['Phone'] = this.phone;
    data['PhotoUrl'] = this.photoUrl;
    return data;
  }
}