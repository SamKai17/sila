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
      timeOfTransaction: (json['time_of_transaction'] as num).toInt(),
      clientId: json['client_id'] as String,
    );

Map<String, dynamic> _$TransactionToJson(_Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalPrice': instance.totalPrice,
      'remainder': instance.remainder,
      'totalPaid': instance.totalPaid,
      'timeOfTransaction': instance.timeOfTransaction,
      'clientId': instance.clientId,
    };
