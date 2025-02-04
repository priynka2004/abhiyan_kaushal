import 'dart:convert';
import 'package:abhiyan_kaushal/api/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = 'https://nashamukti.bonanso.com/auth/';

  Future<Map<String, dynamic>> login(String email, String password) async {
    //final url = Uri.parse('${baseUrl}login/');

    final url = Uri.parse(ApiEndpoints.login);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
}
