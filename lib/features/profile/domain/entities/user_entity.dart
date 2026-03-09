class UserEntity {
  final String id;
  final String email;
  final String fullName;
  final String? phoneNumber;
  final String? countryCode;
  final String? profilePicture;
  final String? profileImage;
  final String? bannerImage;
  final String? aboutMe;
  final String accountType; // personal or company
  final bool isVerified;
  final AddressEntity? address;
  final PersonalAccountEntity? personalAccount;
  final CompanyAccountEntity? companyAccount;
  final String? specialization;
  final String? jobTitle;

  UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.accountType,
    this.phoneNumber,
    this.countryCode,
    this.profilePicture,
    this.profileImage,
    this.bannerImage,
    this.aboutMe,
    this.isVerified = false,
    this.address,
    this.personalAccount,
    this.companyAccount,
    this.specialization,
    this.jobTitle,
  });
}

class AddressEntity {
  final String country;
  final String city;
  final String? street;
  final String? buildingNumber;
  final String? apartmentNumber;

  AddressEntity({
    required this.country,
    required this.city,
    this.street,
    this.buildingNumber,
    this.apartmentNumber,
  });
}

class PersonalAccountEntity {
  final String? gender;
  final String? dateOfBirth;
  final String? specialization;
  final String? generalJob;
  final dynamic skills;

  PersonalAccountEntity({
    this.gender,
    this.dateOfBirth,
    this.specialization,
    this.generalJob,
    this.skills,
  });
}

class CompanyAccountEntity {
  final String? businessSector;
  final String? taxNumber;
  final dynamic servicesOffered;

  CompanyAccountEntity({
    this.businessSector,
    this.taxNumber,
    this.servicesOffered,
  });
}
