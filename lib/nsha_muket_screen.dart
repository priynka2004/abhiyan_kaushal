import 'dart:async';
import 'package:abhiyan_kaushal/api_service/logout_service.dart';
import 'package:flutter/material.dart';
import 'package:abhiyan_kaushal/api_service/benner_service.dart';
import 'package:abhiyan_kaushal/api_service/membership_service.dart';
import 'package:abhiyan_kaushal/api_service/shared_perf_service.dart';
import 'package:abhiyan_kaushal/membership_screen.dart';
import 'package:abhiyan_kaushal/model/mebership_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';


class NshaMuktScreen extends StatefulWidget {
  const NshaMuktScreen({super.key});

  @override
  State<NshaMuktScreen> createState() => _NshaMuktScreenState();
}

class _NshaMuktScreenState extends State<NshaMuktScreen> {
  late Future<String?> _imageUrlFuture;
  late Future<String?> _bannerImageUrlFuture;
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  final LogoutService _logoutService = LogoutService();

  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  String? userName;
  String? userEmail;
  String? profileImage;

  @override
  void initState() {
    super.initState();
    _bannerImageUrlFuture = fetchBannerImage();
    _imageUrlFuture = fetchHeaderImage();
    _loadUserData();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.offset + 400,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

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

  Future<String?> fetchHeaderImage() async {
    try {
      List<Membership> memberships =
          await MembershipService().fetchMemberships();
      if (memberships.isNotEmpty) {
        return memberships[0].membershipTypeImage;
      }
      return null;
    } catch (e) {
      debugPrint("Error fetching image: $e");
      return null;
    }
  }

  Future<String?> fetchBannerImage() async {
    try {
      List<String>? bannerImages = await BannerService().fetchBannerImageUrls();
      if (bannerImages != null && bannerImages.isNotEmpty) {
        return bannerImages[0];
      }
      return null;
    } catch (e) {
      debugPrint("Error fetching banner image: $e");
      return null;
    }
  }

  Future<void> _loadUserData() async {
    final storedEmail = await _sharedPreferencesService.getEmail();
    final storedUsername = await _sharedPreferencesService.getUsername();
    final storedProfileImage =
        await _sharedPreferencesService.getProfileImage();

    setState(() {
      userEmail = storedEmail ?? "No Email";
      userName = storedUsername ?? "No Username";
      profileImage = storedProfileImage ?? "";
    });
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFFDD312D),
                ),
                accountName: Text(userName ?? "User Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFDD312D),
                    )),
                accountEmail: Text(
                  userEmail ?? "user@example.com",
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      profileImage != null && profileImage!.isNotEmpty
                          ? NetworkImage(profileImage!)
                          : const AssetImage("assets/images/default_user.png")
                              as ImageProvider,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Colors.orange),
                title: const Text("About Us"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail, color: Colors.purple),
                title: const Text("Contact Us"),
                onTap: () {},
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Logout"),
                onTap: _logout,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              width: 500,
              color: const Color(0xFFDD312D),
              child: Image.asset(
                "assets/images/image 1.png",
                fit: BoxFit.contain,
              ),
            ),
            FutureBuilder<String?>(
              future: _imageUrlFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data == null) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      "Image not available",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Image.network(
                    snapshot.data!,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text("Failed to load image");
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
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
      ),
    );
  }
}
