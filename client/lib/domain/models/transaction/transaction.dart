import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required String client,
    required double total,
    required double remainder,
    required double paid,
    required String type,
    required String date,
    // items
    // payments
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, Object?> json) => _$TransactionFromJson(json);
}