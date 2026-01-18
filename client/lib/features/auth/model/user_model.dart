import 'dart:convert';

class UserModel {
  final int id;
  final String username;
  final String access;
  final String refresh;
  UserModel({
    required this.id,
    required this.username,
    required this.access,
    required this.refresh,
  });

  UserModel copyWith({
    int? id,
    String? username,
    String? access,
    String? refresh,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      access: access ?? this.access,
      refresh: refresh ?? this.refresh,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'access': access,
      'refresh': refresh,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      username: map['username'] ?? '',
      access: map['access'] ?? '',
      refresh: map['refresh'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, access: $access, refresh: $refresh)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.access == access &&
        other.refresh == refresh;
  }

  @override
  int get hashCode {
    return id.hashCode ^ username.hashCode ^ access.hashCode ^ refresh.hashCode;
  }
}
