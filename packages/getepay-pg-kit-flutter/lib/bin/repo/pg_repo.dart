import '../networking/api_url.dart';
import '../networking/http_client.dart';

class PgRepo {
  Future<Map<String, dynamic>> getLink(
      {required Map<String, dynamic> request}) async {
    try {
      var response = await HttpClient.instance().post(
        url: ApiUrl.getLink,
        body: request,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getInvoiceStatus(
      {required Map<String, dynamic> request}) async {
    try {
      var response = await HttpClient.instance().post(
        url: ApiUrl.getInvoiceStatus,
        body: request,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
