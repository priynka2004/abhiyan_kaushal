import 'package:abhiyan_kaushal/membership_screen.dart';
import 'package:abhiyan_kaushal/nsha_muket_screen.dart';
import 'package:flutter/material.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Image.asset(
              'assets/images/Group 36679.png',
              height: 84,
              width: 90,
            ),
            const SizedBox(height: 16),
            const Text(
              "Password changed",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000000),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Your password has been changed\n successfully",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Inter",
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const NshaMuktScreen();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF0500),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Back to login',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}