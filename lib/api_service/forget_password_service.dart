import 'dart:convert';
import 'package:http/http.dart' as http;

class PasswordService {
  final String _baseUrl = "https://nashamukti.bonanso.com/";

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse("${_baseUrl}forget/password/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      print("Response status: ${response.statusCode}"); // Log the status
      print("Response body: ${response.body}"); // Log the body

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // Check for an error in the response body
        var errorResponse = jsonDecode(response.body);
        return {"error": errorResponse['error'] ?? "Failed to send reset email"};
      }
    } catch (e) {
      return {"error": "Something went wrong. Please try again later."};
    }
  }


  Future<Map<String, dynamic>> resetPassword(String email, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse("${_baseUrl}reset/password/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email,"new_password": newPassword}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"error": jsonDecode(response.body)['message'] ?? "Failed to reset password"};
      }
    } catch (e) {
      return {"error": "Something went wrong. Please try again later."};
    }
  }


  Future<Map<String, dynamic>> changePassword(String token, String oldPassword, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse("${_baseUrl}change/password/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          "old_password": oldPassword,
          "new_password": newPassword
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"error": jsonDecode(response.body)['message'] ?? "Failed to change password"};
      }
    } catch (e) {
      return {"error": "Something went wrong. Please try again later."};
    }
  }


}
