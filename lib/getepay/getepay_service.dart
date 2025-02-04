import 'dart:convert';
import 'package:abhiyan_kaushal/getepay/payment_web_view.dart';
import 'package:http/http.dart' as http;
import 'package:abhiyan_kaushal/api_service/shared_perf_service.dart';


class GetePayService {
  final String requestUrl =
      "https://pay1.getepay.in:8443/getepayPortal/pg/generateInvoice";

  final SharedPreferencesService storageService = SharedPreferencesService();

  Future<Map<String, dynamic>> generateInvoice({
    required String orderId,
    required double amount,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
  }) async {
    try {
      String? token = await storageService.getToken();
      if (token == null) {
        return {"status": "FAILED", "message": "Authentication token missing"};
      }
      print("🔹 Fetched Token: $token");

      String encryptedData = EncryptionService.encryptData(jsonEncode(amount));


      final requestData = {
        "mid": "108",
        "terminal_id": "Getepay.merchant61062@icici",
        "order_id": orderId,
        "amount": encryptedData,
        "currency": "INR",
        "customer_name": customerName,
        "customer_email": customerEmail,
        "customer_mobile_number": customerPhone,
        "return_url": "https://nashamukti.bonanso.com/save/payment/"
      };

      final body = jsonEncode({"Data": requestData});
      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Token $token",
      };

      print("🔹 Request Headers: $headers");
      print("🔹 Encrypted Request Body: $body");

      final response =
      await http.post(Uri.parse(requestUrl), headers: headers, body: body);

      print("🔹 Full API Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.containsKey("Data")) {
          String decryptedData = EncryptionService.decryptData(responseData["Data"]);
          final parsedResponse = jsonDecode(decryptedData);
          print("🔹 Decrypted Response: $parsedResponse");

          return parsedResponse;
        } else {
          return {"status": "FAILED", "message": "Decryption failed"};
        }
      } else {
        return {"status": "FAILED", "message": "Server error: ${response.body}"};
      }
    } catch (e) {
      return {"status": "FAILED", "message": "Network error: $e"};
    }
  }
}
