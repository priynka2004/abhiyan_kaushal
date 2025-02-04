// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Pg_link_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PgLinkResponse _$PgLinkResponseFromJson(Map<String, dynamic> json) {
  return _PgLinkResponse.fromJson(json);
}

/// @nodoc
mixin _$PgLinkResponse {
  String get paymentId => throw _privateConstructorUsedError;
  String get paymentUrl => throw _privateConstructorUsedError;
  String? get qrIntent => throw _privateConstructorUsedError;
  String? get qr => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PgLinkResponseCopyWith<PgLinkResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PgLinkResponseCopyWith<$Res> {
  factory $PgLinkResponseCopyWith(
          PgLinkResponse value, $Res Function(PgLinkResponse) then) =
      _$PgLinkResponseCopyWithImpl<$Res, PgLinkResponse>;
  @useResult
  $Res call(
      {String paymentId, String paymentUrl, String? qrIntent, String? qr});
}

/// @nodoc
class _$PgLinkResponseCopyWithImpl<$Res, $Val extends PgLinkResponse>
    implements $PgLinkResponseCopyWith<$Res> {
  _$PgLinkResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? paymentUrl = null,
    Object? qrIntent = freezed,
    Object? qr = freezed,
  }) {
    return _then(_value.copyWith(
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentUrl: null == paymentUrl
          ? _value.paymentUrl
          : paymentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      qrIntent: freezed == qrIntent
          ? _value.qrIntent
          : qrIntent // ignore: cast_nullable_to_non_nullable
              as String?,
      qr: freezed == qr
          ? _value.qr
          : qr // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PgLinkResponseCopyWith<$Res>
    implements $PgLinkResponseCopyWith<$Res> {
  factory _$$_PgLinkResponseCopyWith(
          _$_PgLinkResponse value, $Res Function(_$_PgLinkResponse) then) =
      __$$_PgLinkResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String paymentId, String paymentUrl, String? qrIntent, String? qr});
}

/// @nodoc
class __$$_PgLinkResponseCopyWithImpl<$Res>
    extends _$PgLinkResponseCopyWithImpl<$Res, _$_PgLinkResponse>
    implements _$$_PgLinkResponseCopyWith<$Res> {
  __$$_PgLinkResponseCopyWithImpl(
      _$_PgLinkResponse _value, $Res Function(_$_PgLinkResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? paymentUrl = null,
    Object? qrIntent = freezed,
    Object? qr = freezed,
  }) {
    return _then(_$_PgLinkResponse(
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentUrl: null == paymentUrl
          ? _value.paymentUrl
          : paymentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      qrIntent: freezed == qrIntent
          ? _value.qrIntent
          : qrIntent // ignore: cast_nullable_to_non_nullable
              as String?,
      qr: freezed == qr
          ? _value.qr
          : qr // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PgLinkResponse implements _PgLinkResponse {
  _$_PgLinkResponse(
      {required this.paymentId,
      required this.paymentUrl,
      required this.qrIntent,
      required this.qr});

  factory _$_PgLinkResponse.fromJson(Map<String, dynamic> json) =>
      _$$_PgLinkResponseFromJson(json);

  @override
  final String paymentId;
  @override
  final String paymentUrl;
  @override
  final String? qrIntent;
  @override
  final String? qr;

  @override
  String toString() {
    return 'PgLinkResponse(paymentId: $paymentId, paymentUrl: $paymentUrl, qrIntent: $qrIntent, qr: $qr)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PgLinkResponse &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.paymentUrl, paymentUrl) ||
                other.paymentUrl == paymentUrl) &&
            (identical(other.qrIntent, qrIntent) ||
                other.qrIntent == qrIntent) &&
            (identical(other.qr, qr) || other.qr == qr));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, paymentId, paymentUrl, qrIntent, qr);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PgLinkResponseCopyWith<_$_PgLinkResponse> get copyWith =>
      __$$_PgLinkResponseCopyWithImpl<_$_PgLinkResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PgLinkResponseToJson(
      this,
    );
  }
}

abstract class _PgLinkResponse implements PgLinkResponse {
  factory _PgLinkResponse(
      {required final String paymentId,
      required final String paymentUrl,
      required final String? qrIntent,
      required final String? qr}) = _$_PgLinkResponse;

  factory _PgLinkResponse.fromJson(Map<String, dynamic> json) =
      _$_PgLinkResponse.fromJson;

  @override
  String get paymentId;
  @override
  String get paymentUrl;
  @override
  String? get qrIntent;
  @override
  String? get qr;
  @override
  @JsonKey(ignore: true)
  _$$_PgLinkResponseCopyWith<_$_PgLinkResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
