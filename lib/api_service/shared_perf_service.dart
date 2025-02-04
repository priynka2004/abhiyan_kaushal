import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('auth_token', token);
  }


  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('auth_token');
  }

  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<void> saveProfileImage(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImage', imageUrl);
  }

  Future<String?> getProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('profileImage');
  }

  Future<void> saveMobile(String mobile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobile', mobile);
  }

  Future<String?> getMobile() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('mobile');
  }


}
