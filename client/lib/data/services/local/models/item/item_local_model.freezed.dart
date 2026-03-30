// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_local_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ItemLocalModel {
  String get id;
  String get name;
  double get price;
  int get quantity; // @Default(0) int synchronized,
  int get isDeleted;

  /// Create a copy of ItemLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ItemLocalModelCopyWith<ItemLocalModel> get copyWith =>
      _$ItemLocalModelCopyWithImpl<ItemLocalModel>(
          this as ItemLocalModel, _$identity);

  /// Serializes this ItemLocalModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ItemLocalModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, price, quantity, isDeleted);

  @override
  String toString() {
    return 'ItemLocalModel(id: $id, name: $name, price: $price, quantity: $quantity, isDeleted: $isDeleted)';
  }
}

/// @nodoc
abstract mixin class $ItemLocalModelCopyWith<$Res> {
  factory $ItemLocalModelCopyWith(
          ItemLocalModel value, $Res Function(ItemLocalModel) _then) =
      _$ItemLocalModelCopyWithImpl;
  @useResult
  $Res call(
      {String id, String name, double price, int quantity, int isDeleted});
}

/// @nodoc
class _$ItemLocalModelCopyWithImpl<$Res>
    implements $ItemLocalModelCopyWith<$Res> {
  _$ItemLocalModelCopyWithImpl(this._self, this._then);

  final ItemLocalModel _self;
  final $Res Function(ItemLocalModel) _then;

  /// Create a copy of ItemLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? quantity = null,
    Object? isDeleted = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ItemLocalModel].
extension ItemLocalModelPatterns on ItemLocalModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ItemLocalModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ItemLocalModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ItemLocalModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ItemLocalModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ItemLocalModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ItemLocalModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id, String name, double price, int quantity, int isDeleted)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ItemLocalModel() when $default != null:
        return $default(
            _that.id, _that.name, _that.price, _that.quantity, _that.isDeleted);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id, String name, double price, int quantity, int isDeleted)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ItemLocalModel():
        return $default(
            _that.id, _that.name, _that.price, _that.quantity, _that.isDeleted);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id, String name, double price, int quantity, int isDeleted)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ItemLocalModel() when $default != null:
        return $default(
            _that.id, _that.name, _that.price, _that.quantity, _that.isDeleted);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ItemLocalModel implements ItemLocalModel {
  const _ItemLocalModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      this.isDeleted = 0});
  factory _ItemLocalModel.fromJson(Map<String, dynamic> json) =>
      _$ItemLocalModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double price;
  @override
  final int quantity;
// @Default(0) int synchronized,
  @override
  @JsonKey()
  final int isDeleted;

  /// Create a copy of ItemLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ItemLocalModelCopyWith<_ItemLocalModel> get copyWith =>
      __$ItemLocalModelCopyWithImpl<_ItemLocalModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ItemLocalModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ItemLocalModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, price, quantity, isDeleted);

  @override
  String toString() {
    return 'ItemLocalModel(id: $id, name: $name, price: $price, quantity: $quantity, isDeleted: $isDeleted)';
  }
}

/// @nodoc
abstract mixin class _$ItemLocalModelCopyWith<$Res>
    implements $ItemLocalModelCopyWith<$Res> {
  factory _$ItemLocalModelCopyWith(
          _ItemLocalModel value, $Res Function(_ItemLocalModel) _then) =
      __$ItemLocalModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id, String name, double price, int quantity, int isDeleted});
}

/// @nodoc
class __$ItemLocalModelCopyWithImpl<$Res>
    implements _$ItemLocalModelCopyWith<$Res> {
  __$ItemLocalModelCopyWithImpl(this._self, this._then);

  final _ItemLocalModel _self;
  final $Res Function(_ItemLocalModel) _then;

  /// Create a copy of ItemLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? quantity = null,
    Object? isDeleted = null,
  }) {
    return _then(_ItemLocalModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
