import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:abhiyan_kaushal/api/api_endpoints.dart';
import 'package:abhiyan_kaushal/api_service/shared_perf_service.dart';

class BannerService {
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  Future<List<String>?> fetchBannerImageUrls() async {
    try {
      String? token = await _sharedPreferencesService.getToken();

      if (token == null) {
        throw Exception("Token not found. Please login again.");
      }

      final response = await http.get(
        Uri.parse(ApiEndpoints.banner),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Debugging: Print the entire response
        print('API Response: $data');

        // Check if banner_images exists and is not null
        if (data['banner_images'] != null) {
          // Prepend the base URL to each relative path
          String baseUrl = 'http://nashamukti.bonanso.com/banner/';
          List<String> bannerImageUrls = List<String>.from(data['banner_images'])
              .map((relativePath) => '$baseUrl$relativePath')
              .toList();
          return bannerImageUrls;
        } else {
          throw Exception("Banner images not found in the response.");
        }
      } else {
        throw Exception("Failed to fetch banners: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching banners: $e");
    }
  }

}
