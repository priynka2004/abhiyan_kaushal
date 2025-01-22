import 'dart:convert';
import 'package:http/http.dart' as http;

class OTPService {

  final String _baseUrl = 'https://nashamukti.bonanso.com/auth/verify/otp/';

  Future<Map<String, dynamic>> verifyOTP(String email, String otpCode) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'otp': otpCode,
        }),
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        throw Exception('Invalid OTP or email');
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during OTP verification: $e');
      throw Exception('Error: $e');
    }
  }

}
