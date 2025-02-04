// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Pg_link_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PgLinkResponse _$$_PgLinkResponseFromJson(Map<String, dynamic> json) =>
    _$_PgLinkResponse(
      paymentId: json['paymentId'] as String,
      paymentUrl: json['paymentUrl'] as String,
      qrIntent: json['qrIntent'] as String?,
      qr: json['qr'] as String?,
    );

Map<String, dynamic> _$$_PgLinkResponseToJson(_$_PgLinkResponse instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'paymentUrl': instance.paymentUrl,
      'qrIntent': instance.qrIntent,
      'qr': instance.qr,
    };
