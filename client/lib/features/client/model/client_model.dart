import 'dart:convert';

class ClientModel {
  final int id;
  final String name;
  final String phone;
  final String city;

  ClientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
  });

  ClientModel copyWith({String? name, String? phone, String? city}) {
    return ClientModel(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'phone': phone, 'city': name};
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'],
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      city: map['city'] ?? '',
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory ClientModel.fromJson(String source) {
    return ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  @override
  String toString() {
    return '$name $phone $city';
  }
}
