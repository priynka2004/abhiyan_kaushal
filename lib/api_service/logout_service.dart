import 'package:abhiyan_kaushal/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogoutService {
  Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        print("No token found, user might not be logged in.");
        return false;
      }

      print("Retrieved Token before logout: $token");

      final response = await http.post(
        Uri.parse(ApiEndpoints.logout),
        headers: {
          'Authorization': 'Bearer $token', // Ensure correct format
          'Content-Type': 'application/json',
        },
      );

      print("Logout Response: ${response.statusCode}");
      print("Logout Response Body: ${response.body}");

      if (response.statusCode == 200) {
        await prefs.remove('auth_token');
        return true;
      } else {
        print("Logout failed with status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error during logout: $e");
      return false;
    }
  }
}
