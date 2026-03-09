import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_cubit.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_state.dart';
import 'package:fodwa/features/profile/domain/entities/user_entity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fodwa/core/intialization/initiDI.dart';
import 'package:fodwa/core/sharedWidget/field.dart';
import 'package:fodwa/core/sharedWidget/defult_drop_down.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

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
  final _dateOfBirthController = TextEditingController();
  final _taxNumberController = TextEditingController();
  final _servicesOfferedController = TextEditingController();
  final _aboutMeController = TextEditingController();

  String? _selectedImagePath;
  bool _isLoading = false;
  bool _isInit = false;

  String? _country;
  String? _city;
  String? _accountType = 'Personal account';
  String? _gender;
  String? _generalJob;
  String? _specialization;
  String? _businessSector;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _apartmentController.dispose();
    _dateOfBirthController.dispose();
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
    if (!_formKey.currentState!.validate()) return;
    
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Update'),
        content: const Text('Are you sure you want to update your profile?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Confirm', style: TextStyle(color: AppColors.primaryColor))),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);
    final cubit = context.read<ProfileCubit>();

    if (_selectedImagePath != null) {
      await cubit.uploadProfileImage(_selectedImagePath!);
    }
    
    AddressEntity newAddress = AddressEntity(
      country: _country ?? '',
      city: _city ?? '',
      street: _streetController.text,
      buildingNumber: _buildingController.text,
      apartmentNumber: _apartmentController.text,
    );

    PersonalAccountEntity? personal;
    CompanyAccountEntity? company;
    if (_accountType?.toLowerCase() == 'company account') {
      company = CompanyAccountEntity(
        businessSector: _businessSector,
        taxNumber: _taxNumberController.text,
        servicesOffered: _servicesOfferedController.text,
      );
    } else {
      personal = PersonalAccountEntity(
        gender: _gender,
        dateOfBirth: _dateOfBirthController.text,
        generalJob: _generalJob,
        specialization: _specialization,
      );
    }

    UserEntity updatedUser = UserEntity(
      id: '0', // Current user ID must be injected or known by cubit
      email: _emailController.text,
      fullName: _nameController.text,
      phoneNumber: _phoneController.text,
      accountType: _accountType ?? 'Personal account',
      aboutMe: _aboutMeController.text,
      address: newAddress,
      personalAccount: personal,
      companyAccount: company,
    );

    await cubit.updateProfile(updatedUser);
    
    setState(() => _isLoading = false);
    if (mounted) Navigator.pop(context);
  }

  String? _sanitizeValue(String? val) {
    if (val == null || val.trim().isEmpty) return null;
    return val;
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(List<String> options, String? currentValue) {
    final List<String> items = List.from(options);
    if (currentValue != null && currentValue.isNotEmpty && !items.contains(currentValue)) {
      items.add(currentValue);
    }
    return items.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList();
  }

  void _initFields(UserEntity user) {
    if (_isInit) return;
    _nameController.text = user.fullName;
    _emailController.text = user.email;
    _phoneController.text = user.phoneNumber ?? '';
    _streetController.text = user.address?.street ?? '';
    _buildingController.text = user.address?.buildingNumber ?? '';
    _apartmentController.text = user.address?.apartmentNumber ?? '';
    _aboutMeController.text = user.aboutMe ?? '';
    
    _country = _sanitizeValue(user.address?.country);
    _city = _sanitizeValue(user.address?.city);
    // Explicitly fallback account type if none is provided
    _accountType = _sanitizeValue(user.accountType) ?? 'Personal account';
    
    if (_accountType?.toLowerCase() == 'company account') {
      _businessSector = _sanitizeValue(user.companyAccount?.businessSector);
      _taxNumberController.text = user.companyAccount?.taxNumber ?? '';
      _servicesOfferedController.text = user.companyAccount?.servicesOffered?.toString() ?? '';
    } else {
      _gender = _sanitizeValue(user.personalAccount?.gender);
      _dateOfBirthController.text = user.personalAccount?.dateOfBirth ?? '';
      _generalJob = _sanitizeValue(user.personalAccount?.generalJob);
      _specialization = _sanitizeValue(user.personalAccount?.specialization);
    }
    _isInit = true;
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppConstants.h * 0.01),
      child: Text(
        text,
        style: TextStyle(fontSize: AppConstants.w * 0.037, fontWeight: FontWeight.w600, color: const Color(0xFF1F2937)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileCubit>()..getProfile(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
          title: Text('Edit Profile', style: TextStyle(color: Colors.black, fontSize: AppConstants.w * 0.048, fontWeight: FontWeight.w600)),
          centerTitle: false,
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
            } else if (state is ProfileSuccess && _isLoading) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully'), backgroundColor: Colors.green));
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading && !_isInit) return const Center(child: CircularProgressIndicator());
            
            final user = state is ProfileSuccess ? state.user : _getStaticUser();
            _initFields(user);

            return SingleChildScrollView(
              padding: EdgeInsets.all(AppConstants.w * 0.04),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: AppConstants.w * 0.15,
                              backgroundImage: _selectedImagePath != null
                                  ? FileImage(File(_selectedImagePath!))
                                  : (user.profilePicture != null || user.profileImage != null)
                                  ? NetworkImage(user.profilePicture ?? user.profileImage!) as ImageProvider
                                  : const NetworkImage('https://tse3.mm.bing.net/th/id/OIP.3JdcHnVxyN3jgFtktwo-3AHaIi?rs=1&pid=ImgDetMain&o=7&rm=3'),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(AppConstants.w * 0.02),
                                decoration: BoxDecoration(color: const Color(0xFF4B5563).withOpacity(0.8), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                                child: Icon(Icons.camera_alt, color: Colors.white, size: AppConstants.w * 0.05),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: AppConstants.h * 0.04),
                    
                    _buildLabel('Full Name *'),
                    CustomTextFormField(
                      label: '', hint: '',
                      controller: _nameController,
                      prefixIcon: Icons.person_outline,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: AppConstants.h * 0.02),
                    
                    _buildLabel('Email *'),
                    CustomTextFormField(
                      label: '', hint: '',
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: AppConstants.h * 0.02),
                    
                    _buildLabel('Phone Number'),
                    CustomTextFormField(label: '', hint: '', controller: _phoneController, keyboardType: TextInputType.phone),
                    SizedBox(height: AppConstants.h * 0.02),
                    
                    _buildLabel('Country *'),
                    DefaultDropdown<String>(
                      hintText: 'Select Country',
                      value: _country,
                      items: _buildDropdownItems(['Palestine', 'Egypt', 'Saudi Arabia'], _country),
                      onChanged: (val) => setState(() => _country = val),
                    ),
                    SizedBox(height: AppConstants.h * 0.02),
                    
                    _buildLabel('City'),
                    DefaultDropdown<String>(
                      hintText: 'Select City',
                      value: _city,
                      items: _buildDropdownItems(['Gaza', 'Cairo', 'Riyadh'], _city),
                      onChanged: (val) => setState(() => _city = val),
                    ),
                    SizedBox(height: AppConstants.h * 0.02),

                    _buildLabel('Street'),
                    CustomTextFormField(label: '', hint: '', controller: _streetController),
                    SizedBox(height: AppConstants.h * 0.02),
                    
                    _buildLabel('Building number'),
                    CustomTextFormField(label: '', hint: '', controller: _buildingController),
                    SizedBox(height: AppConstants.h * 0.02),
                    
                    _buildLabel('Apartment number'),
                    CustomTextFormField(label: '', hint: '', controller: _apartmentController),
                    SizedBox(height: AppConstants.h * 0.02),
                    
                    _buildLabel('Account type *'),
                    DefaultDropdown<String>(
                      hintText: 'Select Account type',
                      value: _accountType,
                      items: _buildDropdownItems(['Personal account', 'Company account'], _accountType),
                      onChanged: (val) => setState(() => _accountType = val),
                    ),
                    SizedBox(height: AppConstants.h * 0.02),
                    
                    if (_accountType?.toLowerCase() == 'personal account' || _accountType?.toLowerCase() == 'personal')
                      ..._buildPersonalEditFields()
                    else
                      ..._buildCompanyEditFields(),
                      
                    _buildLabel('About me'),
                    TextFormField(
                      controller: _aboutMeController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
                        contentPadding: EdgeInsets.all(AppConstants.w * 0.04),
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.h * 0.04),
                    SizedBox(
                      width: double.infinity,
                      height: AppConstants.h * 0.06,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text('Edit Profile', style: TextStyle(color: Colors.white, fontSize: AppConstants.w * 0.04, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildPersonalEditFields() {
    return [
      _buildLabel('Gender'),
      DefaultDropdown<String>(
        hintText: 'Select Gender',
        value: _gender,
        items: _buildDropdownItems(['Male', 'Female'], _gender),
        onChanged: (val) => setState(() => _gender = val),
      ),
      SizedBox(height: AppConstants.h * 0.02),
      
      _buildLabel('date of birth'),
      CustomTextFormField(label: '', hint: 'YYYY-MM-DD', controller: _dateOfBirthController, prefixIcon: Icons.calendar_month),
      SizedBox(height: AppConstants.h * 0.02),
      
      _buildLabel('General job'),
      DefaultDropdown<String>(
        hintText: 'Select Job',
        value: _generalJob,
        items: _buildDropdownItems(['IT', 'Design', 'Marketing'], _generalJob),
        onChanged: (val) => setState(() => _generalJob = val),
      ),
      SizedBox(height: AppConstants.h * 0.02),
      
      _buildLabel('Specialization'),
      DefaultDropdown<String>(
        hintText: 'Select Specialization',
        value: _specialization,
        items: _buildDropdownItems(['Design', 'Development', 'Management'], _specialization),
        onChanged: (val) => setState(() => _specialization = val),
      ),
      SizedBox(height: AppConstants.h * 0.02),
    ];
  }

  List<Widget> _buildCompanyEditFields() {
    return [
      _buildLabel('Business Sector'),
      DefaultDropdown<String>(
        hintText: 'Select Sector',
        value: _businessSector,
        items: _buildDropdownItems(['Information Technology', 'Real Estate', 'Logistics'], _businessSector),
        onChanged: (val) => setState(() => _businessSector = val),
      ),
      SizedBox(height: AppConstants.h * 0.02),
      
      _buildLabel('Tax number'),
      CustomTextFormField(label: '', hint: '', controller: _taxNumberController),
      SizedBox(height: AppConstants.h * 0.02),
      
      _buildLabel('Services Offered'),
      CustomTextFormField(label: '', hint: '', controller: _servicesOfferedController),
      SizedBox(height: AppConstants.h * 0.02),
    ];
  }

  UserEntity _getStaticUser() {
    return UserEntity(
      id: '123456789',
      fullName: 'Minna Basim',
      email: 'Minnabasim12@gmail.com',
      phoneNumber: '598 789 458',
      countryCode: '+966',
      jobTitle: 'UI/UX Designer',
      accountType: 'Company account',
      profilePicture: null,
      address: AddressEntity(
        country: 'Palestine',
        city: 'Gaza',
        street: 'Abu skander',
        buildingNumber: '5555555',
        apartmentNumber: '123456',
      ),
      companyAccount: CompanyAccountEntity(
        businessSector: 'Information Technology',
        taxNumber: '123456789',
        servicesOffered: 'Software Development, IT Consulting',
      ),
    );
  }
}
