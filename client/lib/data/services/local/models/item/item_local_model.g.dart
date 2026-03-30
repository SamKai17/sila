// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ItemLocalModel _$ItemLocalModelFromJson(Map<String, dynamic> json) =>
    _ItemLocalModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      isDeleted: (json['is_deleted'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ItemLocalModelToJson(_ItemLocalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'is_deleted': instance.isDeleted,
    };
