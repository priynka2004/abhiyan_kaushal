import 'package:flutter/material.dart';
import 'package:abhiyan_kaushal/create_account_screen.dart';
import 'package:abhiyan_kaushal/login_screen.dart';

class ExploreAppScreen extends StatefulWidget {
  const ExploreAppScreen({super.key});

  @override
  _ExploreAppScreenState createState() => _ExploreAppScreenState();
}

class _ExploreAppScreenState extends State<ExploreAppScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child: Container(
                      width: 500,
                      color: const Color(0xFFDD312D),
                      child: Image.asset(
                        "assets/images/image 1.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Text(
                      //   'Explore the app',
                      //   style: TextStyle(
                      //     fontFamily: "Poppins",
                      //     fontSize: 32,
                      //     fontWeight: FontWeight.w700,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // const SizedBox(height: 8),
                      Text(
                        'Welcome to the Nasha Mukt Bharat Abhiyaan, a transformative campaign aimed at creating a drug-free India.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const LoginScreen();
                              }));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF0500),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const CreateAccountScreen();
                              }));
                            },
                            style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              side: const BorderSide(color: Color(0xFF747474)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Create account',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 280),
                ],
              ),
            ),
            Positioned(
              bottom: 1,
              right: 5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 100,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/IMG_20250131_155836-removebg-preview.png",
                          width: 120,
                        ),
                        const Text(
                            "           मा. कौशल किशोर जी\n पूर्व केंद्रीय राज्य मंत्री, भारत सरकार"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
