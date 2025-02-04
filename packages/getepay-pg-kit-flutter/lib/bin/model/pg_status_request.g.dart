// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pg_status_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PgStatusRequest _$$_PgStatusRequestFromJson(Map<String, dynamic> json) =>
    _$_PgStatusRequest(
      terminalId: json['terminalId'] as String,
      mid: json['mid'] as String,
      paymentId: json['paymentId'] as String,
      refrenceNo: json['refrenceNo'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$$_PgStatusRequestToJson(_$_PgStatusRequest instance) =>
    <String, dynamic>{
      'terminalId': instance.terminalId,
      'mid': instance.mid,
      'paymentId': instance.paymentId,
      'refrenceNo': instance.refrenceNo,
      'status': instance.status,
    };
