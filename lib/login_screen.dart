import 'package:abhiyan_kaushal/api_service/login_api_service.dart';
import 'package:abhiyan_kaushal/api_service/shared_perf_service.dart';
import 'package:abhiyan_kaushal/create_account_screen.dart';
import 'package:abhiyan_kaushal/forgot_password_screen.dart';
import 'package:abhiyan_kaushal/nsha_muket_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _passwordVisible = false;

  final ApiService _apiService = ApiService();
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  Future<void> _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter email and password");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _apiService.login(email, password);
      if (response.containsKey('token')) {
        await _sharedPreferencesService.saveToken(response['token']);

        await _sharedPreferencesService.saveEmail(email);

        Fluttertoast.showToast(msg: "Login successful");

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NshaMuktScreen()));
      } else {
        Fluttertoast.showToast(msg: "Invalid login credentials");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to login. Please try again.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        leading: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFD8DADC),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.black, size: 14),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Row(
            children: [
              Container(
                height: 100,
                width:250,
                decoration: BoxDecoration(
                  color: const Color(0xFFDD312D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/image 1.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.asset(
                  'assets/images/Star 8.png',
                  height: 42,
                  width: 45,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              const Text(
                'Log in',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins"),
              ),
              const SizedBox(height: 40),
              const Text(
                'Email address',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  suffixIcon: const Icon(Icons.check_circle, color: Colors.black),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: !_passwordVisible, // Toggle visibility
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const ForgotPasswordScreen();
                    }));
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF0500),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Log in',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Inter",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return const CreateAccountScreen();
                          }));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
