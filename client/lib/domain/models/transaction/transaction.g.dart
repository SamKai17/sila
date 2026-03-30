// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Transaction _$TransactionFromJson(Map<String, dynamic> json) => _Transaction(
      id: json['id'] as String,
      totalPrice: (json['total_price'] as num).toDouble(),
      remainder: (json['remainder'] as num).toDouble(),
      totalPaid: (json['total_paid'] as num).toDouble(),
      type: json['type'] as String,
      timeOfTransaction: (json['time_of_transaction'] as num).toInt(),
      clientId: json['client_id'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      payments: (json['payments'] as List<dynamic>?)
              ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TransactionToJson(_Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total_price': instance.totalPrice,
      'remainder': instance.remainder,
      'total_paid': instance.totalPaid,
      'type': instance.type,
      'time_of_transaction': instance.timeOfTransaction,
      'client_id': instance.clientId,
      'items': instance.items,
      'payments': instance.payments,
    };
