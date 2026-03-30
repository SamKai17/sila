// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_local_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClientLocalModel {
  String get id;
  String get name;
  String get phone;
  String get city;
  int get synchronized;
  int get isDeleted;

  /// Create a copy of ClientLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClientLocalModelCopyWith<ClientLocalModel> get copyWith =>
      _$ClientLocalModelCopyWithImpl<ClientLocalModel>(
          this as ClientLocalModel, _$identity);

  /// Serializes this ClientLocalModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClientLocalModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.synchronized, synchronized) ||
                other.synchronized == synchronized) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, phone, city, synchronized, isDeleted);

  @override
  String toString() {
    return 'ClientLocalModel(id: $id, name: $name, phone: $phone, city: $city, synchronized: $synchronized, isDeleted: $isDeleted)';
  }
}

/// @nodoc
abstract mixin class $ClientLocalModelCopyWith<$Res> {
  factory $ClientLocalModelCopyWith(
          ClientLocalModel value, $Res Function(ClientLocalModel) _then) =
      _$ClientLocalModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String phone,
      String city,
      int synchronized,
      int isDeleted});
}

/// @nodoc
class _$ClientLocalModelCopyWithImpl<$Res>
    implements $ClientLocalModelCopyWith<$Res> {
  _$ClientLocalModelCopyWithImpl(this._self, this._then);

  final ClientLocalModel _self;
  final $Res Function(ClientLocalModel) _then;

  /// Create a copy of ClientLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? city = null,
    Object? synchronized = null,
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
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      synchronized: null == synchronized
          ? _self.synchronized
          : synchronized // ignore: cast_nullable_to_non_nullable
              as int,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClientLocalModel].
extension ClientLocalModelPatterns on ClientLocalModel {
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
    TResult Function(_ClientLocalModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientLocalModel() when $default != null:
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
    TResult Function(_ClientLocalModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientLocalModel():
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
    TResult? Function(_ClientLocalModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientLocalModel() when $default != null:
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
    TResult Function(String id, String name, String phone, String city,
            int synchronized, int isDeleted)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClientLocalModel() when $default != null:
        return $default(_that.id, _that.name, _that.phone, _that.city,
            _that.synchronized, _that.isDeleted);
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
    TResult Function(String id, String name, String phone, String city,
            int synchronized, int isDeleted)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientLocalModel():
        return $default(_that.id, _that.name, _that.phone, _that.city,
            _that.synchronized, _that.isDeleted);
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
    TResult? Function(String id, String name, String phone, String city,
            int synchronized, int isDeleted)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClientLocalModel() when $default != null:
        return $default(_that.id, _that.name, _that.phone, _that.city,
            _that.synchronized, _that.isDeleted);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ClientLocalModel implements ClientLocalModel {
  const _ClientLocalModel(
      {required this.id,
      required this.name,
      required this.phone,
      required this.city,
      this.synchronized = 0,
      this.isDeleted = 0});
  factory _ClientLocalModel.fromJson(Map<String, dynamic> json) =>
      _$ClientLocalModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String phone;
  @override
  final String city;
  @override
  @JsonKey()
  final int synchronized;
  @override
  @JsonKey()
  final int isDeleted;

  /// Create a copy of ClientLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClientLocalModelCopyWith<_ClientLocalModel> get copyWith =>
      __$ClientLocalModelCopyWithImpl<_ClientLocalModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClientLocalModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClientLocalModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.synchronized, synchronized) ||
                other.synchronized == synchronized) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, phone, city, synchronized, isDeleted);

  @override
  String toString() {
    return 'ClientLocalModel(id: $id, name: $name, phone: $phone, city: $city, synchronized: $synchronized, isDeleted: $isDeleted)';
  }
}

/// @nodoc
abstract mixin class _$ClientLocalModelCopyWith<$Res>
    implements $ClientLocalModelCopyWith<$Res> {
  factory _$ClientLocalModelCopyWith(
          _ClientLocalModel value, $Res Function(_ClientLocalModel) _then) =
      __$ClientLocalModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String phone,
      String city,
      int synchronized,
      int isDeleted});
}

/// @nodoc
class __$ClientLocalModelCopyWithImpl<$Res>
    implements _$ClientLocalModelCopyWith<$Res> {
  __$ClientLocalModelCopyWithImpl(this._self, this._then);

  final _ClientLocalModel _self;
  final $Res Function(_ClientLocalModel) _then;

  /// Create a copy of ClientLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? city = null,
    Object? synchronized = null,
    Object? isDeleted = null,
  }) {
    return _then(_ClientLocalModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      synchronized: null == synchronized
          ? _self.synchronized
          : synchronized // ignore: cast_nullable_to_non_nullable
              as int,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
