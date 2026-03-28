// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_draft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionDraft _$TransactionDraftFromJson(Map<String, dynamic> json) =>
    _TransactionDraft(
      clientId: json['client_id'] as String,
      paid: (json['paid'] as num).toDouble(),
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionDraftToJson(_TransactionDraft instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'paid': instance.paid,
      'items': instance.items,
    };
