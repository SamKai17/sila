// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionDraft {
  String get clientId;
  double get paid; // required String type,
  List<Item> get items;

  /// Create a copy of TransactionDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TransactionDraftCopyWith<TransactionDraft> get copyWith =>
      _$TransactionDraftCopyWithImpl<TransactionDraft>(
          this as TransactionDraft, _$identity);

  /// Serializes this TransactionDraft to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TransactionDraft &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.paid, paid) || other.paid == paid) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, clientId, paid, const DeepCollectionEquality().hash(items));

  @override
  String toString() {
    return 'TransactionDraft(clientId: $clientId, paid: $paid, items: $items)';
  }
}

/// @nodoc
abstract mixin class $TransactionDraftCopyWith<$Res> {
  factory $TransactionDraftCopyWith(
          TransactionDraft value, $Res Function(TransactionDraft) _then) =
      _$TransactionDraftCopyWithImpl;
  @useResult
  $Res call({String clientId, double paid, List<Item> items});
}

/// @nodoc
class _$TransactionDraftCopyWithImpl<$Res>
    implements $TransactionDraftCopyWith<$Res> {
  _$TransactionDraftCopyWithImpl(this._self, this._then);

  final TransactionDraft _self;
  final $Res Function(TransactionDraft) _then;

  /// Create a copy of TransactionDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? paid = null,
    Object? items = null,
  }) {
    return _then(_self.copyWith(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      paid: null == paid
          ? _self.paid
          : paid // ignore: cast_nullable_to_non_nullable
              as double,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
    ));
  }
}

/// Adds pattern-matching-related methods to [TransactionDraft].
extension TransactionDraftPatterns on TransactionDraft {
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
    TResult Function(_TransactionDraft value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TransactionDraft() when $default != null:
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
    TResult Function(_TransactionDraft value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionDraft():
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
    TResult? Function(_TransactionDraft value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionDraft() when $default != null:
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
    TResult Function(String clientId, double paid, List<Item> items)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TransactionDraft() when $default != null:
        return $default(_that.clientId, _that.paid, _that.items);
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
    TResult Function(String clientId, double paid, List<Item> items) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionDraft():
        return $default(_that.clientId, _that.paid, _that.items);
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
    TResult? Function(String clientId, double paid, List<Item> items)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TransactionDraft() when $default != null:
        return $default(_that.clientId, _that.paid, _that.items);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TransactionDraft implements TransactionDraft {
  const _TransactionDraft(
      {required this.clientId,
      required this.paid,
      required final List<Item> items})
      : _items = items;
  factory _TransactionDraft.fromJson(Map<String, dynamic> json) =>
      _$TransactionDraftFromJson(json);

  @override
  final String clientId;
  @override
  final double paid;
// required String type,
  final List<Item> _items;
// required String type,
  @override
  List<Item> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of TransactionDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TransactionDraftCopyWith<_TransactionDraft> get copyWith =>
      __$TransactionDraftCopyWithImpl<_TransactionDraft>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TransactionDraftToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TransactionDraft &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.paid, paid) || other.paid == paid) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, clientId, paid, const DeepCollectionEquality().hash(_items));

  @override
  String toString() {
    return 'TransactionDraft(clientId: $clientId, paid: $paid, items: $items)';
  }
}

/// @nodoc
abstract mixin class _$TransactionDraftCopyWith<$Res>
    implements $TransactionDraftCopyWith<$Res> {
  factory _$TransactionDraftCopyWith(
          _TransactionDraft value, $Res Function(_TransactionDraft) _then) =
      __$TransactionDraftCopyWithImpl;
  @override
  @useResult
  $Res call({String clientId, double paid, List<Item> items});
}

/// @nodoc
class __$TransactionDraftCopyWithImpl<$Res>
    implements _$TransactionDraftCopyWith<$Res> {
  __$TransactionDraftCopyWithImpl(this._self, this._then);

  final _TransactionDraft _self;
  final $Res Function(_TransactionDraft) _then;

  /// Create a copy of TransactionDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? clientId = null,
    Object? paid = null,
    Object? items = null,
  }) {
    return _then(_TransactionDraft(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      paid: null == paid
          ? _self.paid
          : paid // ignore: cast_nullable_to_non_nullable
              as double,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
    ));
  }
}

// dart format on
