// class UserModel {
//   int? id;
//   String? fullName;
//   String? mobileNumber;
//   String? email;
//   int? age;
//   String? gender;
//   String? village;
//   String? city;
//   String? state;
//   String? district;
//   String? pincode;
//   String? educationQualification;
//   String? profession;
//   String? profilePicture;
//   bool? pledge;
//   String? referralCode;
//   String? password;
//   String? confirmPassword;
//
//   UserModel({
//     this.id,
//     this.fullName,
//     this.mobileNumber,
//     this.email,
//     this.age,
//     this.gender,
//     this.village,
//     this.city,
//     this.state,
//     this.district,
//     this.pincode,
//     this.educationQualification,
//     this.profession,
//     this.profilePicture,
//     this.pledge,
//     this.referralCode,
//     this.password,
//     this.confirmPassword,
//   });
//
//
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'],
//       fullName: json['full_name'],
//       mobileNumber: json['mobile_number'],
//       email: json['email'],
//       age: json['age'],
//       gender: json['gender'],
//       village: json['village'],
//       city: json['city'],
//       state: json['state'],
//       district: json['district'],
//       pincode: json['pincode'],
//       educationQualification: json['education_qualification'],
//       profession: json['profession'],
//       profilePicture: json['profile_picture'],
//       pledge: json['pledge'],
//       referralCode: json['referral_code'],
//       password: json['password'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'full_name': fullName,
//       'mobile_number': mobileNumber,
//       'email': email,
//       'age': age,
//       'gender': gender,
//       'village': village,
//       'city': city,
//       'state': state,
//       'district': district,
//       'pincode': pincode,
//       'education_qualification': educationQualification,
//       'profession': profession,
//       'profile_picture': profilePicture,
//       'pledge': pledge,
//       'referral_code': referralCode,
//       'password': password,
//     };
//   }
// }



class UserModel {
  int? id;
  String? profilePicture;
  String? referralCode;
  String? fullName;
  String? gender;
  String? village;
  String? city;
  String? district;
  String? pincode;
  String? state;
  String? mobileNumber;
  String? email;
  String? password;

  UserModel({
    this.id,
    this.profilePicture,
    this.referralCode,
    this.fullName,
    this.gender,
    this.village,
    this.city,
    this.district,
    this.pincode,
    this.state,
    this.mobileNumber,
    this.email,
    this.password,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      profilePicture: json['profile_picture'],
      referralCode: json['referral_code'],
      fullName: json['full_name'],
      gender: json['gender'],
      village: json['village'],
      city: json['city'],
      district: json['district'],
      pincode: json['pincode'],
      state: json['state'],
      mobileNumber: json['mobile_number'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_picture': profilePicture,
      'referral_code': referralCode,
      'full_name': fullName,
      'gender': gender,
      'village': village,
      'city': city,
      'district': district,
      'pincode': pincode,
      'state': state,
      'mobile_number': mobileNumber,
      'email': email,
      'password': password,
    };
  }
}
