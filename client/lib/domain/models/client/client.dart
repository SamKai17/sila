import 'package:freezed_annotation/freezed_annotation.dart';

part 'client.freezed.dart';
part 'client.g.dart';

@freezed
abstract class Client with _$Client {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Client({
    required String id,
    required String name,
    required String phone,
    required String city,
    // @Default(0) int synchronized,
    // @Default(0) int isDeleted,
  }) = _Client;

  factory Client.fromJson(Map<String, Object?> json) => _$ClientFromJson(json);
}
