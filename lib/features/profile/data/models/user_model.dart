import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.fullName,
    required super.accountType,
    super.phoneNumber,
    super.countryCode,
    super.profilePicture,
    super.profileImage,
    super.bannerImage,
    super.aboutMe,
    super.isVerified,
    super.address,
    super.personalAccount,
    super.companyAccount,
    super.specialization,
    super.jobTitle,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? '',
      phoneNumber: json['phone_number'],
      countryCode: json['country_code'],
      profilePicture: json['profile_picture'],
      profileImage: json['profile_image'],
      bannerImage: json['banner_image'],
      aboutMe: json['about_me'],
      accountType: json['account_type'] ?? 'personal',
      isVerified: json['is_verified'] ?? false,
      specialization: json['specialization'],
      jobTitle: json['job_title'],
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
      personalAccount: json['personal_account'] != null
          ? PersonalAccountModel.fromJson(json['personal_account'])
          : null,
      companyAccount: json['company_account'] != null
          ? CompanyAccountModel.fromJson(json['company_account'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'country_code': countryCode,
      'profile_picture': profilePicture,
      'profile_image': profileImage,
      'banner_image': bannerImage,
      'about_me': aboutMe,
      'account_type': accountType,
      'is_verified': isVerified,
      'specialization': specialization,
      'job_title': jobTitle,
      'address': address != null ? (address as AddressModel).toJson() : null,
      'personal_account': personalAccount != null
          ? (personalAccount as PersonalAccountModel).toJson()
          : null,
      'company_account': companyAccount != null
          ? (companyAccount as CompanyAccountModel).toJson()
          : null,
    };
  }
}

class AddressModel extends AddressEntity {
  AddressModel({
    required super.country,
    required super.city,
    super.street,
    super.buildingNumber,
    super.apartmentNumber,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      street: json['street'],
      buildingNumber: json['building_number'],
      apartmentNumber: json['apartment_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'city': city,
      'street': street,
      'building_number': buildingNumber,
      'apartment_number': apartmentNumber,
    };
  }
}

class PersonalAccountModel extends PersonalAccountEntity {
  PersonalAccountModel({
    super.gender,
    super.dateOfBirth,
    super.specialization,
    super.generalJob,
    super.skills,
  });

  factory PersonalAccountModel.fromJson(Map<String, dynamic> json) {
    return PersonalAccountModel(
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      specialization: json['specialization'],
      generalJob: json['general_job'],
      skills: json['skills'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'specialization': specialization,
      'general_job': generalJob,
      'skills': skills,
    };
  }
}

class CompanyAccountModel extends CompanyAccountEntity {
  CompanyAccountModel({
    super.businessSector,
    super.taxNumber,
    super.servicesOffered,
  });

  factory CompanyAccountModel.fromJson(Map<String, dynamic> json) {
    return CompanyAccountModel(
      businessSector: json['business_sector'],
      taxNumber: json['tax_number'],
      servicesOffered: json['services_offered'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'business_sector': businessSector,
      'tax_number': taxNumber,
      'services_offered': servicesOffered,
    };
  }
}
