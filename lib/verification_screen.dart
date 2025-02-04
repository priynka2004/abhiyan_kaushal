import 'package:abhiyan_kaushal/api_service/otp_api_service.dart';
import 'package:abhiyan_kaushal/login_screen.dart';
import 'package:abhiyan_kaushal/reset_password_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';

class VerificationScreen extends StatefulWidget {
  final String userEmail;

  const VerificationScreen({super.key, required this.userEmail});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String _verificationCode = '';
  int _secondsRemaining = 20;
  Timer? _timer;

  final OTPService _otpService = OTPService();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _verifyOTP() async {
    if (_verificationCode.length == 6) {
      try {
        final result = await _otpService.verifyOTP(widget.userEmail, _verificationCode);
        print('API Response: $result'); // Debug log
        if (result['message'] == 'OTP verified successfully.') {
          Fluttertoast.showToast(
            msg: "OTP verified successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          _showErrorDialog(result['message'] ?? 'Invalid OTP');
        }
      } catch (e) {
        _showErrorDialog('Error: $e');
      }
    }
  }

  void _startTimer() {
    _secondsRemaining = 120; // Set timer to 2 minutes
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }


  Widget _buildNumberButton(String number, [String? letters]) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (_verificationCode.length < 6) {
            setState(() {
              _verificationCode += number;
            });
          }
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (letters != null)
                Text(
                  letters,
                  style:
                      const TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
                ),
            ],
          ),
        ),
      ),
    );
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
        padding: const EdgeInsets.only(top: 30,left: 12,right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please check your \nemail",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000000),
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: "We've sent a code to ",
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Inter",
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: widget.userEmail, // Use the dynamic email here
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(6, (index) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _verificationCode.length > index
                        ? _verificationCode[index]
                        : '',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
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
                onPressed: _verificationCode.length == 6 ? _verifyOTP : null,
                child: const Text(
                  'Verify',
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
              child: TextButton(
                onPressed: _secondsRemaining == 0 ? _startTimer : null,
                child: Text(
                  _secondsRemaining > 0
                      ? "Send code again 00:${_secondsRemaining.toString().padLeft(2, '0')}"
                      : "Send code again",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Row(
                  children: [
                    _buildNumberButton("1"),
                    _buildNumberButton("2", "ABC"),
                    _buildNumberButton("3", "DEF"),
                  ],
                ),
                Row(
                  children: [
                    _buildNumberButton("4", "GHI"),
                    _buildNumberButton("5", "JKL"),
                    _buildNumberButton("6", "MNO"),
                  ],
                ),
                Row(
                  children: [
                    _buildNumberButton("7", "PQRS"),
                    _buildNumberButton("8", "TUV"),
                    _buildNumberButton("9", "WXYZ"),
                  ],
                ),
                Row(
                  children: [
                    _buildNumberButton("+*#"),
                    _buildNumberButton("0"),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_verificationCode.isNotEmpty) {
                            setState(() {
                              _verificationCode = _verificationCode.substring(
                                  0, _verificationCode.length - 1);
                            });
                          }
                        },
                        child: const Center(child: Icon(Icons.backspace)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.black,
                  ),
                  height: 5,
                  width: 100,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
