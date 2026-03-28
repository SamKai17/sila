// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Client _$ClientFromJson(Map<String, dynamic> json) => _Client(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String,
      synchronized: (json['synchronized'] as num?)?.toInt() ?? 0,
      isDeleted: (json['is_deleted'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ClientToJson(_Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'city': instance.city,
      'synchronized': instance.synchronized,
      'isDeleted': instance.isDeleted,
    };
