import 'package:freezed_annotation/freezed_annotation.dart';
part 'item_local_model.g.dart';
part 'item_local_model.freezed.dart';

@freezed
abstract class ItemLocalModel with _$ItemLocalModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ItemLocalModel({
    required String id,
    required String name,
    required double price,
    required int quantity,
    // @Default(0) int synchronized,
    @Default(0) int isDeleted,
  }) = _ItemLocalModel;

  factory ItemLocalModel.fromJson(Map<String, Object?> json) =>
      _$ItemLocalModelFromJson(json);
}
