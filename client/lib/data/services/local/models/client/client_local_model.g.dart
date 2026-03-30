// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClientLocalModel _$ClientLocalModelFromJson(Map<String, dynamic> json) =>
    _ClientLocalModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String,
      synchronized: (json['synchronized'] as num?)?.toInt() ?? 0,
      isDeleted: (json['is_deleted'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ClientLocalModelToJson(_ClientLocalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'city': instance.city,
      'synchronized': instance.synchronized,
      'is_deleted': instance.isDeleted,
    };
