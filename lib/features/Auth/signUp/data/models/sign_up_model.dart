// features/sign_up/data/models/sign_up_model.dart

class SignUpModel {
  final String name;
  final String email;
  final String phone;
  final String pass;
  final String confirmPass;
  final String country;
  final String countryCode;
  final String city;
  final String street;
  final String building;
  final String apartment;
  final String accountType;
  final String aboutMe;
  final String? profileImage;
  final String? bannerImage;
  final DateTime createdAt;

  // ✅ PERSONAL (NULLABLE)
  final String? gender;
  final String? generalJob;
  final String? relatedJob;
  final List<String>? skills;
  final DateTime? dateOfBirth;

  // ✅ BUSINESS (NULLABLE)
  final String? businessSector;
  final List<String>? servicesOffered;
  final String? taxNumber;

  SignUpModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.pass,
    required this.confirmPass,
    required this.accountType,
    required this.country,
    required this.countryCode,
    required this.city,
    required this.street,
    required this.building,
    required this.apartment,
    required this.createdAt,
    this.aboutMe = '',
    this.profileImage,
    this.bannerImage,

    // personal
    this.gender,
    this.generalJob,
    this.relatedJob,
    this.skills,
    this.dateOfBirth,

    // business
    this.businessSector,
    this.servicesOffered,
    this.taxNumber,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    final address = json['address'] ?? {};
    final personal = json['personal_account'] ?? {};
    final company = json['company_account'] ?? {};

    return SignUpModel(
      name: json['full_name'] ?? json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone_number'] ?? json['phone'] ?? '',
      pass: json['password'] ?? json['pass'] ?? '',
      confirmPass: json['confirm_password'] ?? json['confirmPass'] ?? '',
      accountType: json['account_type'] ?? json['accountType'] ?? 'personal',
      country: address['country'] ?? json['country'] ?? '',
      countryCode: json['country_code'] ?? '',
      city: address['city'] ?? json['city'] ?? '',
      street: address['street'] ?? json['street'] ?? '',
      building: address['building_number'] ?? json['building'] ?? '',
      apartment: address['apartment_number'] ?? json['apartment'] ?? '',
      aboutMe: json['about_me'] ?? '',
      profileImage: json['profile_picture'] ?? json['profile_image'],
      bannerImage: json['banner_image'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),

      // ✅ PERSONAL
      gender: personal['gender'] ?? json['gender'],
      generalJob: personal['general_job'] ?? json['general_job'],
      relatedJob: personal['specialization'] ?? json['related_job'],
      skills: personal['skills'] != null
          ? List<String>.from(personal['skills'])
          : json['skills'] != null
          ? List<String>.from(json['skills'])
          : null,
      dateOfBirth: personal['date_of_birth'] != null
          ? DateTime.parse(personal['date_of_birth'])
          : json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,

      // ✅ BUSINESS
      businessSector: company['business_sector'] ?? json['business_sector'],
      servicesOffered: company['services_offered'] != null
          ? List<String>.from(company['services_offered'])
          : json['services_offered'] != null
          ? List<String>.from(json['services_offered'])
          : null,
      taxNumber: company['tax_number'] ?? json['tax_number'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'email': email,
      'phone_number': phone,
      'country_code': countryCode,
      'full_name': name,
      'password': pass,
      'confirm_password': confirmPass,
      'about_me': aboutMe,
      'account_type': accountType,
      'address': {
        'country': country,
        'city': city,
        'street': street,
        'building_number': building,
        'apartment_number': apartment,
      },
      // Guarantee non-null objects for backend validation
      'personal_account': {},
      'company_account': {},
    };

    if (accountType == 'personal') {
      data['personal_account'] = {
        'gender': gender,
        'date_of_birth': dateOfBirth?.toIso8601String().split('T')[0],
        'general_job': generalJob,
        'specialization': relatedJob,
        'skills': skills ?? [],
      };
    } else if (accountType == 'company') {
      data['company_account'] = {
        'business_sector': businessSector,
        'tax_number': taxNumber,
        'services_offered': servicesOffered ?? [],
      };
    }

    // Note: profile_picture and banner_image are NOT sent during sign-up
    // They are readOnly fields in the backend API
    // Images are uploaded separately via /files/profile-image/ and /files/banner-image/
    // after successful registration (handled by UploadProfileImageUseCase)

    return data;
  }
}
