import 'package:freezed_annotation/freezed_annotation.dart';
part 'transaction_local_model.freezed.dart';
part 'transaction_local_model.g.dart';

@freezed
abstract class TransactionLocalModel with _$TransactionLocalModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TransactionLocalModel({
    required String id,
    required double totalPrice,
    required double remainder,
    required double totalPaid,
    required String type,
    required int timeOfTransaction,
    required String clientId,
    @Default(0) int synchronized,
    @Default(0) int isDeleted,
  }) = _TransactionLocalModel;

  factory TransactionLocalModel.fromJson(Map<String, Object?> json) =>
      _$TransactionLocalModelFromJson(json);
}
