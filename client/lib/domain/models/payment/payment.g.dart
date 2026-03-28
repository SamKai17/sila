// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      timeOfPayment: (json['time_of_payment'] as num).toInt(),
    );

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'timeOfPayment': instance.timeOfPayment,
    };
