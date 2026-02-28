import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.g.dart';
part 'payment.freezed.dart';

@freezed
abstract class Payment with _$Payment {
  const factory Payment({
    required String id,
    required double amount,
    required int timeOfPayment,
  }) = _Payment;

  factory Payment.fromJson(Map<String, Object?> json) => _$PaymentFromJson(json);
}