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
    super.addressString,
    super.address,
    super.addresses,
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
      addressString: json['address'] is String ? json['address'] : null,
      address: json['address'] is Map<String, dynamic>
          ? AddressModel.fromJson(json['address'])
          : null,
      addresses: json['addresses'] != null
          ? (json['addresses'] as List).map((x) => AddressModel.fromJson(x)).toList()
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
    final Map<String, dynamic> data = {
      'email': email,
      'full_name': fullName,
      'account_type': accountType,
    };

    if (id != '0' && id.isNotEmpty) data['id'] = id;
    if (phoneNumber != null && phoneNumber!.isNotEmpty) data['phone_number'] = phoneNumber;
    if (countryCode != null && countryCode!.isNotEmpty) data['country_code'] = countryCode;
    if (aboutMe != null) data['about_me'] = aboutMe;
    if (specialization != null) data['specialization'] = specialization;
    if (jobTitle != null) data['job_title'] = jobTitle;

    if (address != null) {
      data['address'] = (address as AddressModel).toJson();
    }

    if (personalAccount != null) {
      final pJson = (personalAccount as PersonalAccountModel).toJson();
      if (pJson.isNotEmpty) data['personal_account'] = pJson;
    }

    if (companyAccount != null) {
      final cJson = (companyAccount as CompanyAccountModel).toJson();
      if (cJson.isNotEmpty) data['company_account'] = cJson;
    }

    return data;
  }
}

class AddressModel extends AddressEntity {
  AddressModel({
    super.id,
    super.firstName,
    super.lastName,
    super.phoneNumber,
    super.altPhoneNumber,
    super.province,
    super.city,
    super.street,
    super.details,
    super.zipCode,
    super.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      altPhoneNumber: json['alt_phone_number'],
      province: json['province'],
      city: json['city'],
      street: json['street'],
      details: json['details'],
      zipCode: json['zip_code'],
      isDefault: json['is_default'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (altPhoneNumber != null) 'alt_phone_number': altPhoneNumber,
      if (province != null) 'province': province,
      if (city != null) 'city': city,
      if (street != null) 'street': street,
      if (details != null) 'details': details,
      if (zipCode != null) 'zip_code': zipCode,
      if (isDefault != null) 'is_default': isDefault,
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
    final Map<String, dynamic> data = {};
    if (gender != null) data['gender'] = gender!.toLowerCase();
    if (dateOfBirth != null) data['date_of_birth'] = dateOfBirth;
    if (specialization != null) data['specialization'] = specialization;
    if (generalJob != null) data['general_job'] = generalJob;
    // Skills must be at least an empty list if this object is sent
    data['skills'] = skills ?? [];
    return data;
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
    final Map<String, dynamic> data = {};
    if (businessSector != null) data['business_sector'] = businessSector;
    if (taxNumber != null) data['tax_number'] = taxNumber;
    // Services must be at least empty list if this object is sent
    data['services_offered'] = servicesOffered ?? [];
    return data;
  }
}
