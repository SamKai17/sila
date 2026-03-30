// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionLocalModel _$TransactionLocalModelFromJson(
        Map<String, dynamic> json) =>
    _TransactionLocalModel(
      id: json['id'] as String,
      totalPrice: (json['total_price'] as num).toDouble(),
      remainder: (json['remainder'] as num).toDouble(),
      totalPaid: (json['total_paid'] as num).toDouble(),
      type: json['type'] as String,
      timeOfTransaction: (json['time_of_transaction'] as num).toInt(),
      clientId: json['client_id'] as String,
      synchronized: (json['synchronized'] as num?)?.toInt() ?? 0,
      isDeleted: (json['is_deleted'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TransactionLocalModelToJson(
        _TransactionLocalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total_price': instance.totalPrice,
      'remainder': instance.remainder,
      'total_paid': instance.totalPaid,
      'type': instance.type,
      'time_of_transaction': instance.timeOfTransaction,
      'client_id': instance.clientId,
      'synchronized': instance.synchronized,
      'is_deleted': instance.isDeleted,
    };
