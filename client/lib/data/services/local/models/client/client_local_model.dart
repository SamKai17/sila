import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_local_model.freezed.dart';
part 'client_local_model.g.dart';

@freezed
abstract class ClientLocalModel with _$ClientLocalModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ClientLocalModel({
    required String id,
    required String name,
    required String phone,
    required String city,
    @Default(0) int synchronized,
    @Default(0) int isDeleted,
  }) = _ClientLocalModel;

  factory ClientLocalModel.fromJson(Map<String, Object?> json) =>
      _$ClientLocalModelFromJson(json);
}
