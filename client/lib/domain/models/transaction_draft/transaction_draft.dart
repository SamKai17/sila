import 'package:client/domain/models/item/item.dart';
import 'package:client/domain/models/payment/payment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'transaction_draft.freezed.dart';
part 'transaction_draft.g.dart';

@freezed
abstract class TransactionDraft with _$TransactionDraft {
  const factory TransactionDraft({
    required String clientId,
    required double paid,
    // required String type,
    required List<Item> items,
  }) = _TransactionDraft;
  factory TransactionDraft.fromJson(Map<String, Object?> json) => _$TransactionDraftFromJson(json);
}