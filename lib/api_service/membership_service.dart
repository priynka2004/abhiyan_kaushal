import 'dart:convert';
import 'package:abhiyan_kaushal/api/api_endpoints.dart';
import 'package:abhiyan_kaushal/model/mebership_model.dart';
import 'package:http/http.dart' as http;

class MembershipService {

 // final String _baseUrl = "https://nashamukti.bonanso.com/memberships/";

  Future<List<Membership>> fetchMemberships() async {
    try {
      final response = await http.get( Uri.parse(ApiEndpoints.memberships),);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Membership.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load memberships');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}



