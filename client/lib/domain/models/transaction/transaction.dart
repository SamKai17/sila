import 'package:client/domain/models/item/item.dart';
import 'package:client/domain/models/payment/payment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required double totalPrice,
    required double remainder,
    required double totalPaid,
    required String type,
    required int timeOfTransaction,
    required String clientId,
    @Default([]) List<Item> items,
    @Default([]) List<Payment> payments,
    @Default(0) int synchronized,
    @Default(0) int isDeleted,
  }) = _Transaction;
  factory Transaction.fromJson(Map<String, Object?> json) => _$TransactionFromJson(json);
}