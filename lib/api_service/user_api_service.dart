import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:abhiyan_kaushal/model/user_model.dart';

class UserApiService {
  static Future<Map<String, dynamic>?> createAccount(UserModel user, File? profilePicture) async {
    const url = 'https://nashamukti.bonanso.com/auth/signup/';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll({
        'Accept': 'application/json',
      });

      request.fields['full_name'] = user.fullName ?? '';
      request.fields['age'] = user.age.toString();
      request.fields['email'] = user.email ?? '';
      request.fields['password'] = user.password ?? '';
      request.fields['confirm_password'] = user.password ?? '';
      request.fields['mobile_number'] = user.mobileNumber ?? '';
      request.fields['gender'] = user.gender ?? '';
      request.fields['village'] = user.village ?? '';
      request.fields['city'] = user.city ?? '';
      request.fields['state'] = user.state ?? '';
      request.fields['district'] = user.district ?? '';
      request.fields['pincode'] = user.pincode ?? '';
      request.fields['education_qualification'] = user.educationQualification ?? '';
      request.fields['profession'] = user.profession ?? '';
      request.fields['pledge'] = user.pledge?.toString() ?? 'false';

      if (profilePicture != null && profilePicture.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_picture',
          profilePicture.path,
        ));
      }

      final response = await request.send();

      if (response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        return json.decode(responseData);
      } else {
        final responseData = await response.stream.bytesToString();
        print('Failed to create account: $responseData');
        return null;
      }
    } catch (error) {
      print('Error occurred: $error');
      return null;
    }
  }
}

