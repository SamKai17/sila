import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.g.dart';
part 'item.freezed.dart';

@freezed
abstract class Item with _$Item {
  const factory Item({
    required String id,
    required String name,
    required double price,
    required int quantity,
  }) = _Item;

  factory Item.fromJson(Map<String, Object?> json) => _$ItemFromJson(json);
}