class ApiEndpoints {
  static const String baseUrl = 'https://nashamukti.bonanso.com';

  // Authentication Endpoints
  static const String login = '$baseUrl/auth/login/';
  static const String logout = '$baseUrl/logout/';
  static const String verifyOtp = '$baseUrl/auth/verify/otp/';
  static const String signup = '$baseUrl/auth/signup/';

  // Memberships Endpoints
  static const String memberships = '$baseUrl/memberships/';
  static const String banner= '$baseUrl/banner/';
}
