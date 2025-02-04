// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pg_invoice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PgInvoiceResponse _$$_PgInvoiceResponseFromJson(Map<String, dynamic> json) =>
    _$_PgInvoiceResponse(
      getepayTxnId: json['getepayTxnId'] as String?,
      mid: json['mid'] as String?,
      txnAmount: json['txnAmount'] as String?,
      txnStatus: json['txnStatus'] as String?,
      merchantOrderNo: json['merchantOrderNo'] as String?,
      udf1: json['udf1'] as String?,
      udf2: json['udf2'] as String?,
      udf3: json['udf3'] as String?,
      udf4: json['udf4'] as String?,
      udf5: json['udf5'] as String?,
      udf6: json['udf6'] as String?,
      udf7: json['udf7'] as String?,
      udf8: json['udf8'] as String?,
      udf9: json['udf9'] as String?,
      udf10: json['udf10'] as String?,
      udf41: json['udf41'] as String?,
      custRefNo: json['custRefNo'] as String?,
      paymentMode: json['paymentMode'] as String?,
      discriminator: json['discriminator'] as String?,
      message: json['message'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      txnDate: json['txnDate'] == null
          ? null
          : DateTime.parse(json['txnDate'] as String),
      surcharge: json['surcharge'] as String?,
      totalAmount: json['totalAmount'] as String?,
      settlementAmount: json['settlementAmount'] as String?,
      settlementRefNo: json['settlementRefNo'] as String?,
      settlementDate: json['settlementDate'] as String?,
      txnNote: json['txnNote'] as String?,
    );

Map<String, dynamic> _$$_PgInvoiceResponseToJson(
        _$_PgInvoiceResponse instance) =>
    <String, dynamic>{
      'getepayTxnId': instance.getepayTxnId,
      'mid': instance.mid,
      'txnAmount': instance.txnAmount,
      'txnStatus': instance.txnStatus,
      'merchantOrderNo': instance.merchantOrderNo,
      'udf1': instance.udf1,
      'udf2': instance.udf2,
      'udf3': instance.udf3,
      'udf4': instance.udf4,
      'udf5': instance.udf5,
      'udf6': instance.udf6,
      'udf7': instance.udf7,
      'udf8': instance.udf8,
      'udf9': instance.udf9,
      'udf10': instance.udf10,
      'udf41': instance.udf41,
      'custRefNo': instance.custRefNo,
      'paymentMode': instance.paymentMode,
      'discriminator': instance.discriminator,
      'message': instance.message,
      'paymentStatus': instance.paymentStatus,
      'txnDate': instance.txnDate?.toIso8601String(),
      'surcharge': instance.surcharge,
      'totalAmount': instance.totalAmount,
      'settlementAmount': instance.settlementAmount,
      'settlementRefNo': instance.settlementRefNo,
      'settlementDate': instance.settlementDate,
      'txnNote': instance.txnNote,
    };
