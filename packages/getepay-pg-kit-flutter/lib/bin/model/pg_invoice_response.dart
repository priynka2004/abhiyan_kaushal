import 'package:freezed_annotation/freezed_annotation.dart';

part 'pg_invoice_response.freezed.dart';
part 'pg_invoice_response.g.dart';

@freezed
class PgInvoiceResponse with _$PgInvoiceResponse {
  factory PgInvoiceResponse({
    String? getepayTxnId,
    String? mid,
    String? txnAmount,
    String? txnStatus,
    String? merchantOrderNo,
    String? udf1,
    String? udf2,
    String? udf3,
    String? udf4,
    String? udf5,
    String? udf6,
    String? udf7,
    String? udf8,
    String? udf9,
    String? udf10,
    String? udf41,
    String? custRefNo,
    String? paymentMode,
    String? discriminator,
    String? message,
    String? paymentStatus,
    DateTime? txnDate,
    String? surcharge,
    String? totalAmount,
    String? settlementAmount,
    String? settlementRefNo,
    String? settlementDate,
    String? txnNote,
  }) = _PgInvoiceResponse;

  factory PgInvoiceResponse.fromJson(Map<String, Object?> json) =>
      _$PgInvoiceResponseFromJson(json);
}