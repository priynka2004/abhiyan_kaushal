import 'package:abhiyan_kaushal/membership_screen.dart';
import 'package:flutter/material.dart';

class NshaMuktScreen extends StatefulWidget {
  const NshaMuktScreen({super.key});

  @override
  State<NshaMuktScreen> createState() => _NshaMuktScreenState();
}

class _NshaMuktScreenState extends State<NshaMuktScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: 393,
              height: 115,
              color: const Color(0xFFDD312D),
              child: Image.asset(
                'assets/images/image 1.png',
                height: 150,
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Image.asset(
                    'assets/images/Group 36693.png',
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const MembershipScreen();
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
                        'Become a member',
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
