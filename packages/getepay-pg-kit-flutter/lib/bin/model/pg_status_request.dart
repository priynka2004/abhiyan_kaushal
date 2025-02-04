import 'package:freezed_annotation/freezed_annotation.dart';

part 'pg_status_request.freezed.dart';
part 'pg_status_request.g.dart';

@unfreezed
class PgStatusRequest with _$PgStatusRequest {
  factory PgStatusRequest({
    required String terminalId,
    required String mid,
    required String paymentId,
    @Default('') String refrenceNo, // transaction id
    @Default('') String status,
  }) = _PgStatusRequest;

  factory PgStatusRequest.fromJson(Map<String, Object?> json) =>
      _$PgStatusRequestFromJson(json);
}
