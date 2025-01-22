import 'dart:io';

import 'package:abhiyan_kaushal/api_service/user_api_service.dart';
import 'package:abhiyan_kaushal/login_screen.dart';
import 'package:abhiyan_kaushal/model/user_model.dart';
import 'package:abhiyan_kaushal/verification_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isPledgeChecked = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final _referralCodeController = TextEditingController();
  final _ageCodeController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _genderController = TextEditingController();
  final _villageController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _districtController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _educationController = TextEditingController();
  final _professionController = TextEditingController();

  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  bool _isLoading = false;

  Future<void> _registerAccount() async {
    if (_formKey.currentState!.validate()) {

      if (_profileImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a profile image.')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        int? age = int.tryParse(_ageCodeController.text) ?? 0;

        final newUser = UserModel(
          fullName: _fullNameController.text,
          email: _emailAddressController.text,
          mobileNumber: _phoneController.text,
          gender: _genderController.text,
          age: age,
          village: _villageController.text,
          city: _cityController.text,
          state: _stateController.text,
          district: _districtController.text,
          pincode: _pincodeController.text,
          educationQualification: _educationController.text,
          profession: _professionController.text,
          password: _passwordController.text,
          profilePicture: _profileImage?.path ?? '',
          pledge: _isPledgeChecked,
          referralCode: _referralCodeController.text,
        );

        final response = await UserApiService.createAccount(
          newUser,
          _profileImage,
        );

        if (response != null && response['message'] != null) {
          if (response['message'].contains("User registered successfully. OTP sent to email.")) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account created successfully! OTP sent to your email.')),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VerificationScreen(
                  userEmail: _emailAddressController.text,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to create account. Please try again.')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to create account. Please try again.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
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
          Padding(
            padding: const EdgeInsets.only(top: 35, right: 16),
            child: Image.asset(
              'assets/images/Star 8.png',
              height: 44,
              width: 46,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF000000),
                  ),
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : const AssetImage('assets/images/Star 8.png'),
                    child: _profileImage == null
                        ? const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    )
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: "Full Name",
                  hintText: "Enter your first name",
                  controller: _fullNameController,
                ),
                const SizedBox(height: 12),
                _buildDropdownField(
                  label: "Gender",
                  items: ["Male", "Female", "Other"],
                  controller: _genderController,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: 'Age',
                  hintText: 'Age',
                  keyboardType: TextInputType.number,
                  controller: _ageCodeController,
                ),
                _buildTextField(
                  label: "Village",
                  hintText: "Enter your village",
                  controller: _villageController,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: "City",
                  hintText: "Enter your city",
                  controller: _cityController,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: "District",
                  hintText: "Enter your district",
                  controller: _districtController,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: "Pincode",
                  hintText: "Enter your pincode",
                  controller: _pincodeController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: "State",
                  hintText: "Enter your state",
                  controller: _stateController,
                ),
                const SizedBox(height: 12),

                _buildTextField(
                  label: "Educational Qualification",
                  hintText: "Enter your qualification",
                  controller: _educationController,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: "Profession",
                  hintText: "Enter your profession",
                  controller: _professionController,
                ),

                const SizedBox(height: 12),
                _buildTextField(
                  label: 'Mobile no.',
                  hintText: 'Enter your Mobile no.',
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: 'Email',
                  hintText: 'Enter your Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailAddressController,
                ),
                const SizedBox(height: 12),

                _buildTextField(
                  label: "Referral Code (Optional)",
                  hintText: "Enter referral code",
                  controller: _referralCodeController,
                  isOptional: true,
                ),
                _buildPasswordField(
                  label: 'Create a password',
                  hintText: 'must be 8 characters',
                  isPasswordVisible: _passwordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),
                _buildPasswordField(
                  label: 'Confirm password',
                  hintText: 'repeat password',
                  isPasswordVisible: _confirmPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _confirmPasswordVisible = !_confirmPasswordVisible;
                    });
                  },
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),
                const Text(
                  'संकल्प करता/करती हूँ कि विकसित भारत व आत्मनिर्भर भारत एवं स्वच्छ व स्वस्थ भारत तया '
                      'नशामुक्त भारत बनाने के आंदोलन को आखिरी सांस तक करता रहूंगा/करती रहूंगी।',
                  style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isPledgeChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isPledgeChecked = value!;
                        });
                      },
                    ),
                    const Text(
                      'I agree to the pledge',
                      style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isPledgeChecked ? _registerAccount : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF0500),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
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
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const LoginScreen();
                              }));
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hintText,
    required bool isPasswordVisible,
    required VoidCallback onVisibilityToggle,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: onVisibilityToggle,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool isOptional = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          validator: (value) {
            if (!isOptional && (value == null || value.isEmpty)) {
              return "This field is required.";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          items: items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
          onChanged: (value) {
            controller.text = value ?? '';
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field is required.";
            }
            return null;
          },
        ),
      ],
    );
  }

}
