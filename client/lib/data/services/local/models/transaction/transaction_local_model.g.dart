// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionLocalModel _$TransactionLocalModelFromJson(
        Map<String, dynamic> json) =>
    _TransactionLocalModel(
      id: json['id'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      remainder: (json['remainder'] as num).toDouble(),
      totalPaid: (json['totalPaid'] as num).toDouble(),
      type: json['type'] as String,
      timeOfTransaction: (json['timeOfTransaction'] as num).toInt(),
      clientId: json['clientId'] as String,
    );

Map<String, dynamic> _$TransactionLocalModelToJson(
        _TransactionLocalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalPrice': instance.totalPrice,
      'remainder': instance.remainder,
      'totalPaid': instance.totalPaid,
      'type': instance.type,
      'timeOfTransaction': instance.timeOfTransaction,
      'clientId': instance.clientId,
    };
