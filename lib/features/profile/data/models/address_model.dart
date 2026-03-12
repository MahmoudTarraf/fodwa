class AddressModel {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? altPhoneNumber;
  final String province;
  final String city;
  final String street;
  final String? details;
  final String? zipCode;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.altPhoneNumber,
    required this.province,
    required this.city,
    required this.street,
    this.details,
    this.zipCode,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      altPhoneNumber: json['alt_phone_number'],
      province: json['province'] ?? '',
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      details: json['details'],
      zipCode: json['zip_code'],
      isDefault: json['is_default'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      if (altPhoneNumber != null) 'alt_phone_number': altPhoneNumber,
      'province': province,
      'city': city,
      'street': street,
      if (details != null) 'details': details,
      if (zipCode != null) 'zip_code': zipCode,
      'is_default': isDefault,
    };
  }
}
