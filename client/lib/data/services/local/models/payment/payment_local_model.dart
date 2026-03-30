import 'package:freezed_annotation/freezed_annotation.dart';
part 'payment_local_model.g.dart';
part 'payment_local_model.freezed.dart';

@freezed
abstract class PaymentLocalModel with _$PaymentLocalModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PaymentLocalModel({
    required String id,
    required double amount,
    required int timeOfPayment,
    // @Default(0) int synchronized,
    @Default(0) int isDeleted,
  }) = _PaymentLocalModel;

  factory PaymentLocalModel.fromJson(Map<String, Object?> json) =>
      _$PaymentLocalModelFromJson(json);
}
