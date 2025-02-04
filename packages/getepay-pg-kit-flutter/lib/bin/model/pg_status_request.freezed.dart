// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pg_status_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PgStatusRequest _$PgStatusRequestFromJson(Map<String, dynamic> json) {
  return _PgStatusRequest.fromJson(json);
}

/// @nodoc
mixin _$PgStatusRequest {
  String get terminalId => throw _privateConstructorUsedError;
  set terminalId(String value) => throw _privateConstructorUsedError;
  String get mid => throw _privateConstructorUsedError;
  set mid(String value) => throw _privateConstructorUsedError;
  String get paymentId => throw _privateConstructorUsedError;
  set paymentId(String value) => throw _privateConstructorUsedError;
  String get refrenceNo => throw _privateConstructorUsedError;
  set refrenceNo(String value) =>
      throw _privateConstructorUsedError; // transaction id
  String get status => throw _privateConstructorUsedError; // transaction id
  set status(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PgStatusRequestCopyWith<PgStatusRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PgStatusRequestCopyWith<$Res> {
  factory $PgStatusRequestCopyWith(
          PgStatusRequest value, $Res Function(PgStatusRequest) then) =
      _$PgStatusRequestCopyWithImpl<$Res, PgStatusRequest>;
  @useResult
  $Res call(
      {String terminalId,
      String mid,
      String paymentId,
      String refrenceNo,
      String status});
}

/// @nodoc
class _$PgStatusRequestCopyWithImpl<$Res, $Val extends PgStatusRequest>
    implements $PgStatusRequestCopyWith<$Res> {
  _$PgStatusRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? terminalId = null,
    Object? mid = null,
    Object? paymentId = null,
    Object? refrenceNo = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      terminalId: null == terminalId
          ? _value.terminalId
          : terminalId // ignore: cast_nullable_to_non_nullable
              as String,
      mid: null == mid
          ? _value.mid
          : mid // ignore: cast_nullable_to_non_nullable
              as String,
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      refrenceNo: null == refrenceNo
          ? _value.refrenceNo
          : refrenceNo // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PgStatusRequestCopyWith<$Res>
    implements $PgStatusRequestCopyWith<$Res> {
  factory _$$_PgStatusRequestCopyWith(
          _$_PgStatusRequest value, $Res Function(_$_PgStatusRequest) then) =
      __$$_PgStatusRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String terminalId,
      String mid,
      String paymentId,
      String refrenceNo,
      String status});
}

/// @nodoc
class __$$_PgStatusRequestCopyWithImpl<$Res>
    extends _$PgStatusRequestCopyWithImpl<$Res, _$_PgStatusRequest>
    implements _$$_PgStatusRequestCopyWith<$Res> {
  __$$_PgStatusRequestCopyWithImpl(
      _$_PgStatusRequest _value, $Res Function(_$_PgStatusRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? terminalId = null,
    Object? mid = null,
    Object? paymentId = null,
    Object? refrenceNo = null,
    Object? status = null,
  }) {
    return _then(_$_PgStatusRequest(
      terminalId: null == terminalId
          ? _value.terminalId
          : terminalId // ignore: cast_nullable_to_non_nullable
              as String,
      mid: null == mid
          ? _value.mid
          : mid // ignore: cast_nullable_to_non_nullable
              as String,
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      refrenceNo: null == refrenceNo
          ? _value.refrenceNo
          : refrenceNo // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PgStatusRequest implements _PgStatusRequest {
  _$_PgStatusRequest(
      {required this.terminalId,
      required this.mid,
      required this.paymentId,
      this.refrenceNo = '',
      this.status = ''});

  factory _$_PgStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$$_PgStatusRequestFromJson(json);

  @override
  String terminalId;
  @override
  String mid;
  @override
  String paymentId;
  @override
  @JsonKey()
  String refrenceNo;
// transaction id
  @override
  @JsonKey()
  String status;

  @override
  String toString() {
    return 'PgStatusRequest(terminalId: $terminalId, mid: $mid, paymentId: $paymentId, refrenceNo: $refrenceNo, status: $status)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PgStatusRequestCopyWith<_$_PgStatusRequest> get copyWith =>
      __$$_PgStatusRequestCopyWithImpl<_$_PgStatusRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PgStatusRequestToJson(
      this,
    );
  }
}

abstract class _PgStatusRequest implements PgStatusRequest {
  factory _PgStatusRequest(
      {required String terminalId,
      required String mid,
      required String paymentId,
      String refrenceNo,
      String status}) = _$_PgStatusRequest;

  factory _PgStatusRequest.fromJson(Map<String, dynamic> json) =
      _$_PgStatusRequest.fromJson;

  @override
  String get terminalId;
  set terminalId(String value);
  @override
  String get mid;
  set mid(String value);
  @override
  String get paymentId;
  set paymentId(String value);
  @override
  String get refrenceNo;
  set refrenceNo(String value);
  @override // transaction id
  String get status; // transaction id
  set status(String value);
  @override
  @JsonKey(ignore: true)
  _$$_PgStatusRequestCopyWith<_$_PgStatusRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
