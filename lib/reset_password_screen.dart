import 'package:abhiyan_kaushal/api_service/forget_password_service.dart';
import 'package:flutter/material.dart';
import 'package:abhiyan_kaushal/password_changed_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _resetPassword() async {
    // Check if passwords match
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match!")),
      );
      return;
    }

    PasswordService service = PasswordService();
    final response = await service.resetPassword(
      _newPasswordController.text,
        _emailController.text
    );

    if (response['success']) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PasswordChangedScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['error']), backgroundColor: Colors.red),
      );
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
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 12, right: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Reset password",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF000000),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please type something you'll remember",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Inter",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "New Password",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureText1,
                decoration: InputDecoration(
                  hintText: "must be 8 characters",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText1 ? Icons.visibility : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText1 = !_obscureText1;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Confirm Password",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureText2,
                decoration: InputDecoration(
                  hintText: "must match the new password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText2 ? Icons.visibility : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText2 = !_obscureText2;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
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
                  onPressed: _resetPassword,
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
