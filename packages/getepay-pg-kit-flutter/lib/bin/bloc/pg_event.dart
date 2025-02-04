part of 'pg_bloc.dart';

@freezed
class PgEvent with _$PgEvent {
  const factory PgEvent.getLink({
    required String terminalId,
    required String mid,
    required double amount,
    required String name,
    required int mobile,
    required String txnType,
    required String udf4,
    required String udf5,
    required String udf6,
    required String udf7,
    required String udf8,
    required String udf9,
    required String callbackUrl,
    required String ru,
  }) = _GetLink;

  const factory PgEvent.getInvoiceStatus({
    required PgStatusRequest request,
  }) = _GetInvoiceStatus;
}
