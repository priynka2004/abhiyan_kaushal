import 'package:freezed_annotation/freezed_annotation.dart';

part 'pg_request.freezed.dart';
part 'pg_request.g.dart';

@freezed
class PgRequest with _$PgRequest {
  factory PgRequest({
    required double amount,
    required String currency,
    required int merchantTransactionId,
    required int mid,
    required String paymentMode,
    required String productType,
    required String terminalId,
    required String transactionDate,
    @Default('Dynamic') String txnNote,
    required String txnType,  //in case of multi payment
    required int udf1,
    @Default('NA') String udf2,
    required String udf3,
    required String udf4,
    required String udf5,
    required String udf6,
    required String udf7,
    required String udf8,
    required String udf9,
    required String callbackUrl,
    required String ru,
  }) = _PgRequest;

  factory PgRequest.fromJson(Map<String, Object?> json) =>
      _$PgRequestFromJson(json);
}
