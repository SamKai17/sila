// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Transaction {
  String get id;
  double get totalPrice;
  double get remainder;
  double get totalPaid; // required String type,
  int get timeOfTransaction;
  String get clientId;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<Transaction> get copyWith =>
      _$TransactionCopyWithImpl<Transaction>(this as Transaction, _$identity);

  /// Serializes this Transaction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Transaction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.remainder, remainder) ||
                other.remainder == remainder) &&
            (identical(other.totalPaid, totalPaid) ||
                other.totalPaid == totalPaid) &&
            (identical(other.timeOfTransaction, timeOfTransaction) ||
                other.timeOfTransaction == timeOfTransaction) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, totalPrice, remainder,
      totalPaid, timeOfTransaction, clientId);

  @override
  String toString() {
    return 'Transaction(id: $id, totalPrice: $totalPrice, remainder: $remainder, totalPaid: $totalPaid, timeOfTransaction: $timeOfTransaction, clientId: $clientId)';
  }
}

/// @nodoc
abstract mixin class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) _then) =
      _$TransactionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      double totalPrice,
      double remainder,
      double totalPaid,
      int timeOfTransaction,
      String clientId});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res> implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._self, this._then);

  final Transaction _self;
  final $Res Function(Transaction) _then;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? totalPrice = null,
    Object? remainder = null,
    Object? totalPaid = null,
    Object? timeOfTransaction = null,
    Object? clientId = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _self.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      remainder: null == remainder
          ? _self.remainder
          : remainder // ignore: cast_nullable_to_non_nullable
              as double,
      totalPaid: null == totalPaid
          ? _self.totalPaid
          : totalPaid // ignore: cast_nullable_to_non_nullable
              as double,
      timeOfTransaction: null == timeOfTransaction
          ? _self.timeOfTransaction
          : timeOfTransaction // ignore: cast_nullable_to_non_nullable
              as int,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Transaction].
extension TransactionPatterns on Transaction {
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
    TResult Function(_Transaction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Transaction() when $default != null:
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
    TResult Function(_Transaction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Transaction():
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
    TResult? Function(_Transaction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Transaction() when $default != null:
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
    TResult Function(String id, double totalPrice, double remainder,
            double totalPaid, int timeOfTransaction, String clientId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Transaction() when $default != null:
        return $default(_that.id, _that.totalPrice, _that.remainder,
            _that.totalPaid, _that.timeOfTransaction, _that.clientId);
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
    TResult Function(String id, double totalPrice, double remainder,
            double totalPaid, int timeOfTransaction, String clientId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Transaction():
        return $default(_that.id, _that.totalPrice, _that.remainder,
            _that.totalPaid, _that.timeOfTransaction, _that.clientId);
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
    TResult? Function(String id, double totalPrice, double remainder,
            double totalPaid, int timeOfTransaction, String clientId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Transaction() when $default != null:
        return $default(_that.id, _that.totalPrice, _that.remainder,
            _that.totalPaid, _that.timeOfTransaction, _that.clientId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Transaction implements Transaction {
  const _Transaction(
      {required this.id,
      required this.totalPrice,
      required this.remainder,
      required this.totalPaid,
      required this.timeOfTransaction,
      required this.clientId});
  factory _Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  @override
  final String id;
  @override
  final double totalPrice;
  @override
  final double remainder;
  @override
  final double totalPaid;
// required String type,
  @override
  final int timeOfTransaction;
  @override
  final String clientId;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransactionCopyWith<_Transaction> get copyWith =>
      __$TransactionCopyWithImpl<_Transaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TransactionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Transaction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.remainder, remainder) ||
                other.remainder == remainder) &&
            (identical(other.totalPaid, totalPaid) ||
                other.totalPaid == totalPaid) &&
            (identical(other.timeOfTransaction, timeOfTransaction) ||
                other.timeOfTransaction == timeOfTransaction) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, totalPrice, remainder,
      totalPaid, timeOfTransaction, clientId);

  @override
  String toString() {
    return 'Transaction(id: $id, totalPrice: $totalPrice, remainder: $remainder, totalPaid: $totalPaid, timeOfTransaction: $timeOfTransaction, clientId: $clientId)';
  }
}

/// @nodoc
abstract mixin class _$TransactionCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(
          _Transaction value, $Res Function(_Transaction) _then) =
      __$TransactionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      double totalPrice,
      double remainder,
      double totalPaid,
      int timeOfTransaction,
      String clientId});
}

/// @nodoc
class __$TransactionCopyWithImpl<$Res> implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(this._self, this._then);

  final _Transaction _self;
  final $Res Function(_Transaction) _then;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? totalPrice = null,
    Object? remainder = null,
    Object? totalPaid = null,
    Object? timeOfTransaction = null,
    Object? clientId = null,
  }) {
    return _then(_Transaction(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      totalPrice: null == totalPrice
          ? _self.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      remainder: null == remainder
          ? _self.remainder
          : remainder // ignore: cast_nullable_to_non_nullable
              as double,
      totalPaid: null == totalPaid
          ? _self.totalPaid
          : totalPaid // ignore: cast_nullable_to_non_nullable
              as double,
      timeOfTransaction: null == timeOfTransaction
          ? _self.timeOfTransaction
          : timeOfTransaction // ignore: cast_nullable_to_non_nullable
              as int,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
