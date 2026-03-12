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
  final String? addressString;
  final AddressEntity? address; // Used for putting/updating
  final List<AddressEntity>? addresses; // Used for GET
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
    this.addressString,
    this.address,
    this.addresses,
    this.personalAccount,
    this.companyAccount,
    this.specialization,
    this.jobTitle,
  });
}

class AddressEntity {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? altPhoneNumber;
  final String? province;
  final String? city;
  final String? street;
  final String? details;
  final String? zipCode;
  final bool? isDefault;

  AddressEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.altPhoneNumber,
    this.province,
    this.city,
    this.street,
    this.details,
    this.zipCode,
    this.isDefault,
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
