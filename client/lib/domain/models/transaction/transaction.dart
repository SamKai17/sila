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
    // required String type,
    required int timeOfTransaction,
    required String clientId,
    // items
    // payments
    // client
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, Object?> json) => _$TransactionFromJson(json);
}