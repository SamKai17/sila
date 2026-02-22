// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Transaction _$TransactionFromJson(Map<String, dynamic> json) => _Transaction(
      id: json['id'] as String,
      client: json['client'] as String,
      total: (json['total'] as num).toDouble(),
      remainder: (json['remainder'] as num).toDouble(),
      paid: (json['paid'] as num).toDouble(),
      type: json['type'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$TransactionToJson(_Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client': instance.client,
      'total': instance.total,
      'remainder': instance.remainder,
      'paid': instance.paid,
      'type': instance.type,
      'date': instance.date,
    };
