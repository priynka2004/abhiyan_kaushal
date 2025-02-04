import 'package:abhiyan_kaushal/api_service/forget_password_service.dart';  // Make sure you have an API service class for this.
import 'package:abhiyan_kaushal/api_service/shared_perf_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:abhiyan_kaushal/login_screen.dart';
import 'package:abhiyan_kaushal/verification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;

  Future<void> _forgotPassword() async {
    String email = _emailController.text.trim();

    // Use SharedPreferencesService to get the saved email
    String? savedEmail = await SharedPreferencesService().getEmail();

    if (savedEmail == null || savedEmail.toLowerCase() != email.toLowerCase()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The email entered does not match your logged-in email!"), backgroundColor: Colors.red),
      );
      return;
    }

    PasswordService service = PasswordService();
    final response = await service.forgotPassword(email);

    if (response.containsKey('error')) {
      if (response['error'] == "User with this email does not exist.") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No user found with this email!"), backgroundColor: Colors.red),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['error']), backgroundColor: Colors.red),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset email sent!"), backgroundColor: Colors.green),
      );
    }
  }


  Future<String?> getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }


  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }

  Future<void> _loadSavedEmail() async {
    String? savedEmail = await getSavedEmail();
    if (savedEmail != null) {
      _emailController.text = savedEmail;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        leading: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD8DADC), width: 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 14),
              onPressed: () => Navigator.pop(context),
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
              const SizedBox(width: 8,),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.asset(
                  'assets/images/Star 8.png',
                  height: 43,
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
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF000000),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Don't worry! It happens. Please enter the email associated with your account.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "Email address",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF000000),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Enter your email address",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
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
                    onPressed: _isLoading ? null : _forgotPassword,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'Send code',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Remember password? ',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Inter",
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: 'Log in',
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Inter",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
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
      ),
    );
  }
}
