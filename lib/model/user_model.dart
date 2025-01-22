// class UserModel {
//   int? id;
//   String? firstName;
//   String? middleName;
//   String? lastName;
//   String? mobileNumber;
//   String? email;
//   String? age;
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
//     this.firstName,
//     this.middleName,
//     this.lastName,
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
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'],
//       firstName: json['first_name'],
//       middleName: json['middle_name'],
//       lastName: json['last_name'],
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
//       'first_name': firstName,
//       'middle_name': middleName,
//       'last_name': lastName,
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
  String? fullName;
  String? mobileNumber;
  String? email;
  int? age;
  String? gender;
  String? village;
  String? city;
  String? state;
  String? district;
  String? pincode;
  String? educationQualification;
  String? profession;
  String? profilePicture;
  bool? pledge;
  String? referralCode;
  String? password;
  String? confirmPassword;

  UserModel({
    this.id,
    this.fullName,
    this.mobileNumber,
    this.email,
    this.age,
    this.gender,
    this.village,
    this.city,
    this.state,
    this.district,
    this.pincode,
    this.educationQualification,
    this.profession,
    this.profilePicture,
    this.pledge,
    this.referralCode,
    this.password,
    this.confirmPassword,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['full_name'],
      mobileNumber: json['mobile_number'],
      email: json['email'],
      age: json['age'],
      gender: json['gender'],
      village: json['village'],
      city: json['city'],
      state: json['state'],
      district: json['district'],
      pincode: json['pincode'],
      educationQualification: json['education_qualification'],
      profession: json['profession'],
      profilePicture: json['profile_picture'],
      pledge: json['pledge'],
      referralCode: json['referral_code'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'mobile_number': mobileNumber,
      'email': email,
      'age': age,
      'gender': gender,
      'village': village,
      'city': city,
      'state': state,
      'district': district,
      'pincode': pincode,
      'education_qualification': educationQualification,
      'profession': profession,
      'profile_picture': profilePicture,
      'pledge': pledge,
      'referral_code': referralCode,
      'password': password,
    };
  }
}
