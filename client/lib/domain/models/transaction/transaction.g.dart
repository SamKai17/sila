// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Transaction _$TransactionFromJson(Map<String, dynamic> json) => _Transaction(
      id: json['id'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      remainder: (json['remainder'] as num).toDouble(),
      totalPaid: (json['totalPaid'] as num).toDouble(),
      type: json['type'] as String,
      timeOfTransaction: (json['timeOfTransaction'] as num).toInt(),
      clientId: json['clientId'] as String,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      payments: (json['payments'] as List<dynamic>?)
          ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionToJson(_Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalPrice': instance.totalPrice,
      'remainder': instance.remainder,
      'totalPaid': instance.totalPaid,
      'type': instance.type,
      'timeOfTransaction': instance.timeOfTransaction,
      'clientId': instance.clientId,
      'items': instance.items,
      'payments': instance.payments,
    };
