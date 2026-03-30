// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_local_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentLocalModel {
  String get id;
  double get amount;
  int get timeOfPayment; // @Default(0) int synchronized,
  int get isDeleted;

  /// Create a copy of PaymentLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaymentLocalModelCopyWith<PaymentLocalModel> get copyWith =>
      _$PaymentLocalModelCopyWithImpl<PaymentLocalModel>(
          this as PaymentLocalModel, _$identity);

  /// Serializes this PaymentLocalModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaymentLocalModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.timeOfPayment, timeOfPayment) ||
                other.timeOfPayment == timeOfPayment) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, amount, timeOfPayment, isDeleted);

  @override
  String toString() {
    return 'PaymentLocalModel(id: $id, amount: $amount, timeOfPayment: $timeOfPayment, isDeleted: $isDeleted)';
  }
}

/// @nodoc
abstract mixin class $PaymentLocalModelCopyWith<$Res> {
  factory $PaymentLocalModelCopyWith(
          PaymentLocalModel value, $Res Function(PaymentLocalModel) _then) =
      _$PaymentLocalModelCopyWithImpl;
  @useResult
  $Res call({String id, double amount, int timeOfPayment, int isDeleted});
}

/// @nodoc
class _$PaymentLocalModelCopyWithImpl<$Res>
    implements $PaymentLocalModelCopyWith<$Res> {
  _$PaymentLocalModelCopyWithImpl(this._self, this._then);

  final PaymentLocalModel _self;
  final $Res Function(PaymentLocalModel) _then;

  /// Create a copy of PaymentLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? timeOfPayment = null,
    Object? isDeleted = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      timeOfPayment: null == timeOfPayment
          ? _self.timeOfPayment
          : timeOfPayment // ignore: cast_nullable_to_non_nullable
              as int,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PaymentLocalModel].
extension PaymentLocalModelPatterns on PaymentLocalModel {
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
    TResult Function(_PaymentLocalModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaymentLocalModel() when $default != null:
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
    TResult Function(_PaymentLocalModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaymentLocalModel():
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
    TResult? Function(_PaymentLocalModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaymentLocalModel() when $default != null:
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
            String id, double amount, int timeOfPayment, int isDeleted)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaymentLocalModel() when $default != null:
        return $default(
            _that.id, _that.amount, _that.timeOfPayment, _that.isDeleted);
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
    TResult Function(String id, double amount, int timeOfPayment, int isDeleted)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaymentLocalModel():
        return $default(
            _that.id, _that.amount, _that.timeOfPayment, _that.isDeleted);
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
            String id, double amount, int timeOfPayment, int isDeleted)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaymentLocalModel() when $default != null:
        return $default(
            _that.id, _that.amount, _that.timeOfPayment, _that.isDeleted);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _PaymentLocalModel implements PaymentLocalModel {
  const _PaymentLocalModel(
      {required this.id,
      required this.amount,
      required this.timeOfPayment,
      this.isDeleted = 0});
  factory _PaymentLocalModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentLocalModelFromJson(json);

  @override
  final String id;
  @override
  final double amount;
  @override
  final int timeOfPayment;
// @Default(0) int synchronized,
  @override
  @JsonKey()
  final int isDeleted;

  /// Create a copy of PaymentLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaymentLocalModelCopyWith<_PaymentLocalModel> get copyWith =>
      __$PaymentLocalModelCopyWithImpl<_PaymentLocalModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaymentLocalModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaymentLocalModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.timeOfPayment, timeOfPayment) ||
                other.timeOfPayment == timeOfPayment) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, amount, timeOfPayment, isDeleted);

  @override
  String toString() {
    return 'PaymentLocalModel(id: $id, amount: $amount, timeOfPayment: $timeOfPayment, isDeleted: $isDeleted)';
  }
}

/// @nodoc
abstract mixin class _$PaymentLocalModelCopyWith<$Res>
    implements $PaymentLocalModelCopyWith<$Res> {
  factory _$PaymentLocalModelCopyWith(
          _PaymentLocalModel value, $Res Function(_PaymentLocalModel) _then) =
      __$PaymentLocalModelCopyWithImpl;
  @override
  @useResult
  $Res call({String id, double amount, int timeOfPayment, int isDeleted});
}

/// @nodoc
class __$PaymentLocalModelCopyWithImpl<$Res>
    implements _$PaymentLocalModelCopyWith<$Res> {
  __$PaymentLocalModelCopyWithImpl(this._self, this._then);

  final _PaymentLocalModel _self;
  final $Res Function(_PaymentLocalModel) _then;

  /// Create a copy of PaymentLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? timeOfPayment = null,
    Object? isDeleted = null,
  }) {
    return _then(_PaymentLocalModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      timeOfPayment: null == timeOfPayment
          ? _self.timeOfPayment
          : timeOfPayment // ignore: cast_nullable_to_non_nullable
              as int,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
