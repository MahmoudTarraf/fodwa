import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_cubit.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_state.dart';
import 'package:fodwa/features/profile/domain/entities/user_entity.dart';
import 'package:fodwa/features/profile/data/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fodwa/core/intialization/initiDI.dart';
import 'package:fodwa/core/sharedWidget/field.dart';
import 'package:fodwa/core/sharedWidget/defult_drop_down.dart';
import 'package:fodwa/core/sharedWidget/large_field.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/widgets/login_text.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/widgets/phone/build_phone_number.dart';
import 'package:fodwa/features/Auth/signUp/presentation/widgets/signUpWidget/dropDownLists/date_birth.dart';
import 'package:fodwa/features/Auth/signUp/presentation/widgets/signUpWidget/dropDownLists/build_skills.dart';

class EditProfileScreen extends StatefulWidget {
  final UserEntity? initialUser;

  const EditProfileScreen({Key? key, this.initialUser}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _buildingController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _taxNumberController = TextEditingController();
  final _servicesOfferedController = TextEditingController();
  final _aboutMeController = TextEditingController();

  String? _selectedImagePath;
  bool _isSaving = false;
  bool _isInit = false;

  String? _province;
  String? _city;
  String _accountType = 'Personal account';
  String? _gender;
  String? _generalJob;
  String? _specialization;
  String? _businessSector;
  String? _countryCode;
  DateTime? _selectedDateOfBirth;
  String? _fullPhoneNumber;
  List<String> _selectedSkills = [];

  // Store the original user data for ID etc.
  UserEntity? _originalUser;

  late ProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ProfileCubit>();
    if (widget.initialUser != null) {
      _initFields(widget.initialUser!);
    } else {
      _cubit.getProfile();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _apartmentController.dispose();
    _taxNumberController.dispose();
    _servicesOfferedController.dispose();
    _aboutMeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );
    if (image != null) {
      setState(() {
        _selectedImagePath = image.path;
      });
    }
  }

  Future<void> _saveProfile() async {
    // We allow partial updates, so we don't strictly block on form validation
    // unless there are actual error patterns in the future.
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.whiteBGAlert,

        title: Text(
          'UpDate',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: AppConstants.w * 0.048,
            color: AppColors.headingTextAlert,
          ),
        ),
        content: Text(
          'Are you sure you want to update?',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: AppConstants.w * 0.037, // 14 / 375
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'No',
              style: TextStyle(
                color: AppColors.headingTextAlert,
                fontSize: AppConstants.w * 0.037, // 14 / 375
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'UP Date',
              style: TextStyle(
                color: AppColors.actionColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isSaving = true);

    if (_selectedImagePath != null) {
      await _cubit.uploadProfileImage(_selectedImagePath!);
    }

    // Map display account type back to API value
    final String apiAccountType = _accountType.toLowerCase().contains('company')
        ? 'company'
        : 'personal';

    AddressModel newAddress = AddressModel(
      firstName: _originalUser?.addresses?.isNotEmpty == true
          ? _originalUser!.addresses!.first.firstName
          : null,
      lastName: _originalUser?.addresses?.isNotEmpty == true
          ? _originalUser!.addresses!.first.lastName
          : null,
      province: _province ?? '',
      city: _city ?? '',
      street: _streetController.text,
      details: _buildingController.text,
      zipCode: _apartmentController.text,
    );

    PersonalAccountModel? personal;
    CompanyAccountModel? company;
    if (apiAccountType == 'personal') {
      personal = PersonalAccountModel(
        gender: _gender?.toLowerCase(),
        dateOfBirth: _selectedDateOfBirth != null
            ? _selectedDateOfBirth!.toIso8601String().split('T')[0]
            : null,
        generalJob: _generalJob,
        specialization: _specialization,
        skills: _selectedSkills,
      );
    } else {
      company = CompanyAccountModel(
        businessSector: _businessSector,
        taxNumber: _taxNumberController.text,
        servicesOffered: _originalUser?.companyAccount?.servicesOffered ?? [],
      );
    }

    UserModel updatedUser = UserModel(
      id: _originalUser?.id ?? '0',
      email: _emailController.text,
      fullName: _nameController.text,
      phoneNumber:
          _fullPhoneNumber ??
          _originalUser?.phoneNumber ??
          _phoneController.text,
      countryCode: _countryCode,
      accountType: apiAccountType,
      aboutMe: _aboutMeController.text,
      address: newAddress,
      personalAccount: personal,
      companyAccount: company,
    );

    await _cubit.updateProfile(updatedUser);
  }

  String? _sanitizeValue(String? val) {
    if (val == null || val.trim().isEmpty) return null;
    return val;
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(
    List<String> options,
    String? currentValue,
  ) {
    final List<String> items = List.from(options);
    if (currentValue != null &&
        currentValue.isNotEmpty &&
        !items.contains(currentValue)) {
      items.add(currentValue);
    }
    return items
        .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
        .toList();
  }

  void _initFields(UserEntity user) {
    if (_isInit) return;
    _originalUser = user;

    _nameController.text = user.fullName;
    _emailController.text = user.email;

    // Strip country code to avoid duplication in InternationalPhoneNumberInput
    _countryCode = user.countryCode;
    String rawPhone = user.phoneNumber ?? '';
    if (_countryCode != null && rawPhone.startsWith(_countryCode!)) {
      rawPhone = rawPhone.substring(_countryCode!.length);
    } else if (_countryCode != null &&
        rawPhone.startsWith(_countryCode!.replaceAll('+', ''))) {
      rawPhone = rawPhone.substring(_countryCode!.replaceAll('+', '').length);
    }
    _phoneController.text = rawPhone.trim();
    _fullPhoneNumber = user.phoneNumber;

    // Map address fields
    final address = user.addresses != null && user.addresses!.isNotEmpty
        ? user.addresses!.first
        : user.address;

    _streetController.text = address?.street ?? '';
    _buildingController.text = address?.details ?? '';
    _apartmentController.text = address?.zipCode ?? '';
    _aboutMeController.text = user.aboutMe ?? '';

    _province = _sanitizeValue(address?.province);
    _city = _sanitizeValue(address?.city);

    // Normalize account type for display
    final rawType = user.accountType.toLowerCase();
    if (rawType == 'company' || rawType == 'company account') {
      _accountType = 'Company account';
      _businessSector = _sanitizeValue(user.companyAccount?.businessSector);
      _taxNumberController.text = user.companyAccount?.taxNumber ?? '';
      _servicesOfferedController.text =
          user.companyAccount?.servicesOffered?.toString() ?? '';
    } else {
      _accountType = 'Personal account';
      _gender = _sanitizeValue(user.personalAccount?.gender);

      String? dobStr = user.personalAccount?.dateOfBirth;
      if (dobStr != null && dobStr.isNotEmpty) {
        try {
          _selectedDateOfBirth = DateTime.parse(dobStr);
        } catch (_) {
          // ignore parsing errors
        }
      }

      _generalJob = _sanitizeValue(user.personalAccount?.generalJob);
      _specialization = _sanitizeValue(user.personalAccount?.specialization);
      _selectedSkills = user.personalAccount?.skills != null
          ? List<String>.from(user.personalAccount!.skills)
          : [];
    }
    _isInit = true;
  }

  String _isoCodeFromCountryCode(String? countryCode) {
    if (countryCode == null) return 'SA';
    switch (countryCode.replaceAll('+', '')) {
      case '966':
        return 'SA';
      case '970':
        return 'PS';
      case '20':
        return 'EG';
      case '962':
        return 'JO';
      case '961':
        return 'LB';
      case '971':
        return 'AE';
      case '963':
        return 'SY';
      default:
        return 'SA';
    }
  }

  @override
  Widget build(BuildContext context) {
    AppConstants.initSize(context);

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: AppConstants.w * 0.048,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: false,
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateSuccess) {
              setState(() => _isSaving = false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is ProfileError) {
              setState(() => _isSaving = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if ((state is ProfileLoading) && !_isInit) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError && !_isInit) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                    SizedBox(height: AppConstants.h * 0.02),
                    Text(state.message, textAlign: TextAlign.center),
                    SizedBox(height: AppConstants.h * 0.02),
                    ElevatedButton(
                      onPressed: () => _cubit.getProfile(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // Get user from whatever state has it or the initial user
            UserEntity? user;
            if (state is ProfileLoaded) user = state.user;
            if (state is ProfileUpdateSuccess) user = state.user;
            if (user == null && widget.initialUser != null)
              user = widget.initialUser;

            if (user != null) {
              _initFields(user);
            } else if (!_isInit) {
              return const Center(child: CircularProgressIndicator());
            }

            return _buildForm();
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    final bool isPersonal = _accountType.toLowerCase().contains('personal');

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppConstants.w * 0.064),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Profile image picker ───
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  alignment: Alignment.center, // center all children by default
                  children: [
                    CircleAvatar(
                      radius: AppConstants.w * 0.15,
                      backgroundImage: _selectedImagePath != null
                          ? FileImage(File(_selectedImagePath!))
                          : (_originalUser?.profilePicture != null ||
                                _originalUser?.profileImage != null)
                          ? NetworkImage(
                                  _originalUser!.profilePicture ??
                                      _originalUser!.profileImage!,
                                )
                                as ImageProvider
                          : const NetworkImage(
                              'https://tse3.mm.bing.net/th/id/OIP.3JdcHnVxyN3jgFtktwo-3AHaIi?rs=1&pid=ImgDetMain&o=7&rm=3',
                            ),
                    ),
                    Image.asset(
                      AppImages.cameraProfile,
                      color: Colors.white,
                      width: AppConstants.w * 0.09,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppConstants.h * 0.04),

            // ─── Full Name ───
            build_field_name('Full Name'),
            SizedBox(height: AppConstants.h * 0.00985),
            CustomTextFormField(
              label: 'Full Name',
              hint: 'Your name',
              controller: _nameController,
              
              prefixImage: AppImages.profile,
            ),
            SizedBox(height: AppConstants.h * 0.015),

            // ─── Email ───
            build_field_name('Email'),
            SizedBox(height: AppConstants.h * 0.00985),
            CustomTextFormField(
              label: 'Email',
              hint: 'example@gmail.com',
              controller: _emailController,
              prefixImage: AppImages.smsImage,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: AppConstants.h * 0.015),

            // ─── Phone Number ───
            build_field_name('Phone Number'),
            SizedBox(height: AppConstants.h * 0.00985),
            BuildPhoneNumber(
              controller: _phoneController,
              isoCode: _isoCodeFromCountryCode(_countryCode),
              onChanged: (number, isoCode) {
                _fullPhoneNumber = number;
              },
            ),
            SizedBox(height: AppConstants.h * 0.015),

            // ─── Country ───
            build_field_name('Country'),
            SizedBox(height: AppConstants.h * 0.00985),
            DefaultDropdown<String>(
              hintText: 'Select Country',
              value: _province,
              items: _buildDropdownItems([
                'Palestine',
                'Egypt',
                'Saudi Arabia',
                'Syria',
              ], _province),
              onChanged: (val) => setState(() => _province = val),
            ),
            SizedBox(height: AppConstants.h * 0.015),

            // ─── City ───
            build_field_name('City'),
            SizedBox(height: AppConstants.h * 0.00985),
            DefaultDropdown<String>(
              hintText: 'Select City',
              value: _city,
              items: _buildDropdownItems([
                'Gaza',
                'Cairo',
                'Riyadh',
                'Damascus',
              ], _city),
              onChanged: (val) => setState(() => _city = val),
            ),
            SizedBox(height: AppConstants.h * 0.015),

            // ─── Street ───
            build_field_name('Street'),
            SizedBox(height: AppConstants.h * 0.00985),
            CustomTextFormField(
              label: 'Street',
              hint: 'Street Name',
              controller: _streetController,
            ),
            SizedBox(height: AppConstants.h * 0.015),

            // ─── Building number ───
            build_field_name('Building number'),
            SizedBox(height: AppConstants.h * 0.00985),
            CustomTextFormField(
              label: 'Building Number',
              hint: '5555555',
              controller: _buildingController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: AppConstants.h * 0.015),

            // ─── Apartment number ───
            build_field_name('Apartment number'),
            SizedBox(height: AppConstants.h * 0.00985),
            CustomTextFormField(
              label: 'Apartment number',
              hint: '123456',
              controller: _apartmentController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: AppConstants.h * 0.015),

            // ─── Account type ───
            build_field_name('Account type'),
            SizedBox(height: AppConstants.h * 0.00985),
            DefaultDropdown<String>(
              hintText: 'Select Account type',
              value: _accountType,
              items: _buildDropdownItems([
                'Personal account',
                'Company account',
              ], _accountType),
              onChanged: (val) {
                if (val != null && val != _accountType) {
                  setState(() {
                    _accountType = val;
                    // Clear opposite fields when switching
                    if (val.toLowerCase().contains('personal')) {
                      _businessSector = null;
                      _taxNumberController.clear();
                      _servicesOfferedController.clear();
                    } else {
                      _gender = null;
                      _selectedDateOfBirth = null;
                      _generalJob = null;
                      _specialization = null;
                    }
                  });
                }
              },
            ),
            SizedBox(height: AppConstants.h * 0.015),

            // ─── Conditional fields ───
            if (isPersonal)
              ..._buildPersonalEditFields()
            else
              ..._buildCompanyEditFields(),

            // ─── About me ───
            build_field_name('About me'),
            SizedBox(height: AppConstants.h * 0.01),
            CustomTextField(
              controller: _aboutMeController,
              maxLines: 2,
              maxLength: 700,
            ),

            SizedBox(height: AppConstants.h * 0.04),

            // ─── Save button ───
            SizedBox(
              width: double.infinity,
              height: AppConstants.h * 0.06,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppConstants.w * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Personal fields ───
  List<Widget> _buildPersonalEditFields() {
    return [
      build_field_name('gender'),
      SizedBox(height: AppConstants.h * 0.00985),
      DefaultDropdown<String>(
        hintText: 'Select Gender',
        value: _gender,
        items: _buildDropdownItems(['Male', 'Female'], _gender),
        onChanged: (val) => setState(() => _gender = val),
      ),
      SizedBox(height: AppConstants.h * 0.015),

      // Strictly reuse the refactored signup date picker
      DateOfBirthPicker(
        value: _selectedDateOfBirth,
        onDateSelected: (date) {
          setState(() {
            _selectedDateOfBirth = date;
          });
        },
      ),

      build_field_name('General job'),
      SizedBox(height: AppConstants.h * 0.00985),
      DefaultDropdown<String>(
        hintText: 'Select Job',
        value: _generalJob,
        items: _buildDropdownItems(['IT', 'Design', 'Marketing'], _generalJob),
        onChanged: (val) => setState(() => _generalJob = val),
      ),
      SizedBox(height: AppConstants.h * 0.015),

      build_field_name('Specialization'),
      SizedBox(height: AppConstants.h * 0.00985),
      DefaultDropdown<String>(
        hintText: 'Select Specialization',
        value: _specialization,
        items: _buildDropdownItems([
          'Design',
          'Development',
          'Management',
        ], _specialization),
        onChanged: (val) => setState(() => _specialization = val),
      ),
      SizedBox(height: AppConstants.h * 0.015),

      BuildSkillsSelector(
        selectedSkills: _selectedSkills,
        onAddSkill: (skill) {
          if (!_selectedSkills.contains(skill)) {
            setState(() => _selectedSkills.add(skill));
          }
        },
        onRemoveSkill: (skill) {
          setState(() => _selectedSkills.remove(skill));
        },
      ),
      SizedBox(height: AppConstants.h * 0.015),
    ];
  }

  // ─── Company fields ───
  List<Widget> _buildCompanyEditFields() {
    return [
      build_field_name('Business Sector'),
      SizedBox(height: AppConstants.h * 0.00985),
      DefaultDropdown<String>(
        hintText: 'Select Sector',
        value: _businessSector,
        items: _buildDropdownItems([
          'Information Technology',
          'Real Estate',
          'Logistics',
        ], _businessSector),
        onChanged: (val) => setState(() => _businessSector = val),
      ),
      SizedBox(height: AppConstants.h * 0.015),

      build_field_name('Tax number'),
      SizedBox(height: AppConstants.h * 0.00985),
      CustomTextFormField(
        label: 'Tax number',
        hint: '00000',
        controller: _taxNumberController,
        keyboardType: TextInputType.number,
      ),
      SizedBox(height: AppConstants.h * 0.015),

      build_field_name('Services Offered'),
      SizedBox(height: AppConstants.h * 0.00985),
      CustomTextFormField(
        label: 'Services offered',
        hint: 'Cleaning, Maintenance ...',
        controller: _servicesOfferedController,
      ),
      SizedBox(height: AppConstants.h * 0.015),
    ];
  }
}
