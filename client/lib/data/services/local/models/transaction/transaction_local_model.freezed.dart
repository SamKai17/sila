// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_local_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionLocalModel {
  String get id;
  double get totalPrice;
  double get remainder;
  double get totalPaid;
  String get type;
  int get timeOfTransaction;
  String get clientId;
  int get synchronized;
  int get isDeleted;

  /// Create a copy of TransactionLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransactionLocalModelCopyWith<TransactionLocalModel> get copyWith =>
      _$TransactionLocalModelCopyWithImpl<TransactionLocalModel>(
          this as TransactionLocalModel, _$identity);

  /// Serializes this TransactionLocalModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionLocalModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.remainder, remainder) ||
                other.remainder == remainder) &&
            (identical(other.totalPaid, totalPaid) ||
                other.totalPaid == totalPaid) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timeOfTransaction, timeOfTransaction) ||
                other.timeOfTransaction == timeOfTransaction) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.synchronized, synchronized) ||
                other.synchronized == synchronized) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, totalPrice, remainder,
      totalPaid, type, timeOfTransaction, clientId, synchronized, isDeleted);

  @override
  String toString() {
    return 'TransactionLocalModel(id: $id, totalPrice: $totalPrice, remainder: $remainder, totalPaid: $totalPaid, type: $type, timeOfTransaction: $timeOfTransaction, clientId: $clientId, synchronized: $synchronized, isDeleted: $isDeleted)';
  }
}

/// @nodoc
abstract mixin class $TransactionLocalModelCopyWith<$Res> {
  factory $TransactionLocalModelCopyWith(TransactionLocalModel value,
          $Res Function(TransactionLocalModel) _then) =
      _$TransactionLocalModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      double totalPrice,
      double remainder,
      double totalPaid,
      String type,
      int timeOfTransaction,
      String clientId,
      int synchronized,
      int isDeleted});
}

/// @nodoc
class _$TransactionLocalModelCopyWithImpl<$Res>
    implements $TransactionLocalModelCopyWith<$Res> {
  _$TransactionLocalModelCopyWithImpl(this._self, this._then);

  final TransactionLocalModel _self;
  final $Res Function(TransactionLocalModel) _then;

  /// Create a copy of TransactionLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? totalPrice = null,
    Object? remainder = null,
    Object? totalPaid = null,
    Object? type = null,
    Object? timeOfTransaction = null,
    Object? clientId = null,
    Object? synchronized = null,
    Object? isDeleted = null,
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
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      timeOfTransaction: null == timeOfTransaction
          ? _self.timeOfTransaction
          : timeOfTransaction // ignore: cast_nullable_to_non_nullable
              as int,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
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

/// Adds pattern-matching-related methods to [TransactionLocalModel].
extension TransactionLocalModelPatterns on TransactionLocalModel {
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
    TResult Function(_TransactionLocalModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TransactionLocalModel() when $default != null:
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
    TResult Function(_TransactionLocalModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionLocalModel():
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
    TResult? Function(_TransactionLocalModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionLocalModel() when $default != null:
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
            String id,
            double totalPrice,
            double remainder,
            double totalPaid,
            String type,
            int timeOfTransaction,
            String clientId,
            int synchronized,
            int isDeleted)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TransactionLocalModel() when $default != null:
        return $default(
            _that.id,
            _that.totalPrice,
            _that.remainder,
            _that.totalPaid,
            _that.type,
            _that.timeOfTransaction,
            _that.clientId,
            _that.synchronized,
            _that.isDeleted);
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
            String id,
            double totalPrice,
            double remainder,
            double totalPaid,
            String type,
            int timeOfTransaction,
            String clientId,
            int synchronized,
            int isDeleted)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionLocalModel():
        return $default(
            _that.id,
            _that.totalPrice,
            _that.remainder,
            _that.totalPaid,
            _that.type,
            _that.timeOfTransaction,
            _that.clientId,
            _that.synchronized,
            _that.isDeleted);
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
            String id,
            double totalPrice,
            double remainder,
            double totalPaid,
            String type,
            int timeOfTransaction,
            String clientId,
            int synchronized,
            int isDeleted)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionLocalModel() when $default != null:
        return $default(
            _that.id,
            _that.totalPrice,
            _that.remainder,
            _that.totalPaid,
            _that.type,
            _that.timeOfTransaction,
            _that.clientId,
            _that.synchronized,
            _that.isDeleted);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _TransactionLocalModel implements TransactionLocalModel {
  const _TransactionLocalModel(
      {required this.id,
      required this.totalPrice,
      required this.remainder,
      required this.totalPaid,
      required this.type,
      required this.timeOfTransaction,
      required this.clientId,
      this.synchronized = 0,
      this.isDeleted = 0});
  factory _TransactionLocalModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionLocalModelFromJson(json);

  @override
  final String id;
  @override
  final double totalPrice;
  @override
  final double remainder;
  @override
  final double totalPaid;
  @override
  final String type;
  @override
  final int timeOfTransaction;
  @override
  final String clientId;
  @override
  @JsonKey()
  final int synchronized;
  @override
  @JsonKey()
  final int isDeleted;

  /// Create a copy of TransactionLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransactionLocalModelCopyWith<_TransactionLocalModel> get copyWith =>
      __$TransactionLocalModelCopyWithImpl<_TransactionLocalModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TransactionLocalModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TransactionLocalModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.remainder, remainder) ||
                other.remainder == remainder) &&
            (identical(other.totalPaid, totalPaid) ||
                other.totalPaid == totalPaid) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timeOfTransaction, timeOfTransaction) ||
                other.timeOfTransaction == timeOfTransaction) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.synchronized, synchronized) ||
                other.synchronized == synchronized) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, totalPrice, remainder,
      totalPaid, type, timeOfTransaction, clientId, synchronized, isDeleted);

  @override
  String toString() {
    return 'TransactionLocalModel(id: $id, totalPrice: $totalPrice, remainder: $remainder, totalPaid: $totalPaid, type: $type, timeOfTransaction: $timeOfTransaction, clientId: $clientId, synchronized: $synchronized, isDeleted: $isDeleted)';
  }
}

/// @nodoc
abstract mixin class _$TransactionLocalModelCopyWith<$Res>
    implements $TransactionLocalModelCopyWith<$Res> {
  factory _$TransactionLocalModelCopyWith(_TransactionLocalModel value,
          $Res Function(_TransactionLocalModel) _then) =
      __$TransactionLocalModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      double totalPrice,
      double remainder,
      double totalPaid,
      String type,
      int timeOfTransaction,
      String clientId,
      int synchronized,
      int isDeleted});
}

/// @nodoc
class __$TransactionLocalModelCopyWithImpl<$Res>
    implements _$TransactionLocalModelCopyWith<$Res> {
  __$TransactionLocalModelCopyWithImpl(this._self, this._then);

  final _TransactionLocalModel _self;
  final $Res Function(_TransactionLocalModel) _then;

  /// Create a copy of TransactionLocalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? totalPrice = null,
    Object? remainder = null,
    Object? totalPaid = null,
    Object? type = null,
    Object? timeOfTransaction = null,
    Object? clientId = null,
    Object? synchronized = null,
    Object? isDeleted = null,
  }) {
    return _then(_TransactionLocalModel(
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
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      timeOfTransaction: null == timeOfTransaction
          ? _self.timeOfTransaction
          : timeOfTransaction // ignore: cast_nullable_to_non_nullable
              as int,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
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
