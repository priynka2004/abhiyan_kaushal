import 'package:freezed_annotation/freezed_annotation.dart';

part 'Pg_link_response.freezed.dart';
part 'Pg_link_response.g.dart';

@freezed
class PgLinkResponse with _$PgLinkResponse {
  factory PgLinkResponse({
    required String paymentId,
    required String paymentUrl,
    required String? qrIntent,
    required String? qr,
  }) = _PgLinkResponse;

  factory PgLinkResponse.fromJson(Map<String, Object?> json) =>
      _$PgLinkResponseFromJson(json);
}
