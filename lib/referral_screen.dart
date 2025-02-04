import 'package:abhiyan_kaushal/api_service/logout_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {

  final LogoutService _logoutService =
      LogoutService();

  Future<void> _logout() async {
    bool success = await _logoutService.logout();
    if (success) {
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logout failed, try again")),
      );
    }
  }

  Future<List<Map<String, String>>> fetchReferrals() async {
    final response =
        await http.get(Uri.parse("https://example.com/api/referrals"));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((e) => {
                "name": e["name"].toString(),
                "mobile": e["mobile"].toString(),
              })
          .toList();
    } else {
      throw Exception("Failed to load referrals");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          leading: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD8DADC), width: 1.0),
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.all(8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.black, size: 14),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          actions: [
            Row(
              children: [
                Container(
                  height: 100,
                  width: 250,
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
                const SizedBox(
                  width: 10,
                ),
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
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF0500),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'आप हमारे आजीवन सदस्य हैं',
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
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle "Refer your friend" button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF0500),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "नए सदस्यों को आमंत्रित करें",
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
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "My Referrals:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter",
                            color: Color(0xFF000000),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF0500),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFFF0500),
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "151",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          
                  // Expanded(
                  //   child: FutureBuilder<List<Map<String, dynamic>>>(
                  //     future: fetchReferrals(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.waiting) {
                  //         return const Center(child: CircularProgressIndicator());
                  //       } else if (snapshot.hasError) {
                  //         return const Center(child: Text("Error loading referrals"));
                  //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  //         return const Center(child: Text("No referrals found"));
                  //       } else {
                  //         return ListView.builder(
                  //           itemCount: snapshot.data!.length,
                  //           itemBuilder: (context, index) {
                  //             final referral = snapshot.data![index];
                  //             return Card(
                  //               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(10),
                  //               ),
                  //               child: ListTile(
                  //                 leading: const Icon(Icons.person, color: Colors.red),
                  //                 title: Text(referral["name"].toString(),
                  //                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  //                 subtitle: Text(referral["mobile"].toString(),
                  //                     style: const TextStyle(fontSize: 14)),
                  //               ),
                  //             );
                  //           },
                  //         );
                  //       }
                  //     },
                  //   ),
                  // ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
