class Membership {
  final String membershipTypeName;
  final String membershipTypeImage;
  final double memberPrice;
  final String membershipDescription;

  Membership({
    required this.membershipTypeName,
    required this.membershipTypeImage,
    required this.memberPrice,
    required this.membershipDescription,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      membershipTypeName: json['membership_type_name'] ?? '',
      membershipTypeImage: json['membership_type_image'] ?? '',
      memberPrice: (json['member_price'] ?? 0).toDouble(),
      membershipDescription: json['membership_description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'membership_type_name': membershipTypeName,
      'membership_type_image': membershipTypeImage,
      'member_price': memberPrice,
      'membership_description': membershipDescription,
    };
  }
}
