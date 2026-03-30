// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentLocalModel _$PaymentLocalModelFromJson(Map<String, dynamic> json) =>
    _PaymentLocalModel(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      timeOfPayment: (json['time_of_payment'] as num).toInt(),
      isDeleted: (json['is_deleted'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PaymentLocalModelToJson(_PaymentLocalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'time_of_payment': instance.timeOfPayment,
      'is_deleted': instance.isDeleted,
    };
