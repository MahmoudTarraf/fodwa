import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/features/profile/domain/entities/user_entity.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_cubit.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_state.dart';
import 'package:fodwa/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:fodwa/core/sharedWidget/field.dart';
import 'package:fodwa/core/sharedWidget/defult_drop_down.dart';
import 'package:fodwa/core/sharedWidget/large_field.dart';
import 'package:fodwa/core/intialization/initiDI.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/widgets/login_text.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/widgets/phone/build_phone_number.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  late ProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ProfileCubit>()..getProfile();
  }

  /// Re-fetch profile when returning from edit screen
  void _navigateToEdit(UserEntity user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(initialUser: user),
      ),
    );
    _cubit.getProfile();
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
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: AppConstants.w * 0.064,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Personal Details',
            style: TextStyle(
              color: Color(0xFF212121),
              fontSize: AppConstants.w * 0.048,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: false,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                    SizedBox(height: AppConstants.h * 0.02),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: AppConstants.w * 0.048,
                        color: AppColors.headingTextAlert,
                      ),
                    ),
                    SizedBox(height: AppConstants.h * 0.02),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.logoutPrimary,
                      ),
                      onPressed: () => _cubit.getProfile(),
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          color: AppColors.whiteProfile,
                          fontSize: AppConstants.w * 0.043, // 16 / 375
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            UserEntity? user;
            if (state is ProfileLoaded) {
              user = state.user;
            } else if (state is ProfileUpdateSuccess) {
              user = state.user;
            }

            if (user == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return _buildBody(user);
          },
        ),
      ),
    );
  }

  Widget _buildBody(UserEntity user) {
    final address = user.addresses != null && user.addresses!.isNotEmpty
        ? user.addresses!.first
        : user.address;

    final bool isPersonal = user.accountType.toLowerCase() == 'personal';
    final String displayAccountType = isPersonal
        ? 'Personal account'
        : 'Company account';

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.064,
        vertical: AppConstants.h * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Header ───
          _buildHeader(user),
          SizedBox(height: AppConstants.h * 0.02),
          Divider(color: AppColors.dividerColor, thickness: 1),
          SizedBox(height: AppConstants.h * 0.02),

          // ─── Full Name ───
          build_field_name('Full Name *'),
          SizedBox(height: AppConstants.h * 0.00985),
          CustomTextFormField(
            label: 'Full Name',
            hint: '',
            controller: TextEditingController(
              text: user.fullName.replaceAllMapped(
                RegExp(r'([a-z])([A-Z])'),
                (Match m) => '${m[1]} ${m[2]}',
              ),
            ),
            readOnly: true,
            prefixImage: AppImages.profile,
          ),
          SizedBox(height: AppConstants.h * 0.015),

          // ─── Email ───
          build_field_name('Email *'),
          SizedBox(height: AppConstants.h * 0.00985),
          CustomTextFormField(
            label: 'Email',
            hint: '',
            controller: TextEditingController(text: user.email),
            readOnly: true,
            prefixImage: AppImages.smsImage,
          ),
          SizedBox(height: AppConstants.h * 0.015),

          // ─── Phone Number ───
          build_field_name('Phone Number'),
          SizedBox(height: AppConstants.h * 0.00985),
          BuildPhoneNumber(
            controller: TextEditingController(text: user.phoneNumber ?? ''),
            isoCode: _isoCodeFromCountryCode(user.countryCode),
            enabled: false,
          ),
          SizedBox(height: AppConstants.h * 0.015),

          // ─── Country ───
          build_field_name('Country *'),
          SizedBox(height: AppConstants.h * 0.00985),
          IgnorePointer(
            child: DefaultDropdown<String>(
              hintText: address?.province ?? '',
              items: _singleItemDropdown(address?.province),
              onChanged: (val) {},
              value: _sanitize(address?.province),
            ),
          ),
          SizedBox(height: AppConstants.h * 0.015),

          // ─── City ───
          build_field_name('City'),
          SizedBox(height: AppConstants.h * 0.00985),
          IgnorePointer(
            child: DefaultDropdown<String>(
              hintText: address?.city ?? '',
              items: _singleItemDropdown(address?.city),
              onChanged: (val) {},
              value: _sanitize(address?.city),
            ),
          ),
          SizedBox(height: AppConstants.h * 0.015),

          // ─── Street ───
          build_field_name('Street'),
          SizedBox(height: AppConstants.h * 0.00985),
          CustomTextFormField(
            label: 'Street',
            hint: '',
            controller: TextEditingController(text: address?.street ?? ''),
            readOnly: true,
          ),
          SizedBox(height: AppConstants.h * 0.015),

          // ─── Building number ───
          build_field_name('Building number'),
          SizedBox(height: AppConstants.h * 0.00985),
          CustomTextFormField(
            label: 'Building Number',
            hint: '',
            controller: TextEditingController(text: address?.details ?? ''),
            readOnly: true,
          ),
          SizedBox(height: AppConstants.h * 0.015),

          // ─── Apartment number ───
          build_field_name('Apartment number'),
          SizedBox(height: AppConstants.h * 0.00985),
          CustomTextFormField(
            label: 'Apartment number',
            hint: '',
            controller: TextEditingController(text: address?.zipCode ?? ''),
            readOnly: true,
          ),
          SizedBox(height: AppConstants.h * 0.015),

          // ─── Account type ───
          build_field_name('Account type *'),
          SizedBox(height: AppConstants.h * 0.00985),
          IgnorePointer(
            child: DefaultDropdown<String>(
              hintText: displayAccountType,
              items: [
                DropdownMenuItem(
                  value: displayAccountType,
                  child: Text(displayAccountType),
                ),
              ],
              onChanged: (val) {},
              value: displayAccountType,
            ),
          ),
          SizedBox(height: AppConstants.h * 0.015),

          // ─── Conditional fields based on account type ───
          if (isPersonal)
            ..._buildPersonalFields(user)
          else
            ..._buildCompanyFields(user),

          // ─── About me ───
          build_field_name('About me'),
          SizedBox(height: AppConstants.h * 0.01),
          CustomTextField(
            controller: TextEditingController(text: user.aboutMe ?? ''),
            maxLines: 2,
            maxLength: 700,
            readOnly: true,
          ),
          SizedBox(height: AppConstants.h * 0.04),
          SizedBox(
            width: double.infinity,
            height: AppConstants.h * 0.06,
            child: ElevatedButton(
              onPressed: () {
                _navigateToEdit(user);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
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
    );
  }

  // ─── Personal account fields (read-only) ───
  List<Widget> _buildPersonalFields(UserEntity user) {
    final pa = user.personalAccount;
    return [
      // Gender
      build_field_name('gender'),
      SizedBox(height: AppConstants.h * 0.00985),
      IgnorePointer(
        child: DefaultDropdown<String>(
          hintText: pa?.gender ?? '',
          items: _singleItemDropdown(pa?.gender),
          onChanged: (val) {},
          value: _sanitize(pa?.gender),
        ),
      ),
      SizedBox(height: AppConstants.h * 0.015),

      // Date of birth
      build_field_name('date of birth'),
      SizedBox(height: AppConstants.h * 0.00985),
      CustomTextFormField(
        label: '',
        hint: '',
        controller: TextEditingController(text: pa?.dateOfBirth ?? ''),
        readOnly: true,
        prefixIcon: Icons.calendar_month,
      ),
      SizedBox(height: AppConstants.h * 0.015),

      // General job
      build_field_name('General job'),
      SizedBox(height: AppConstants.h * 0.00985),
      IgnorePointer(
        child: DefaultDropdown<String>(
          hintText: pa?.generalJob ?? '',
          items: _singleItemDropdown(pa?.generalJob),
          onChanged: (val) {},
          value: _sanitize(pa?.generalJob),
        ),
      ),
      SizedBox(height: AppConstants.h * 0.015),

      // Specialization
      build_field_name('Specialization'),
      SizedBox(height: AppConstants.h * 0.00985),
      IgnorePointer(
        child: DefaultDropdown<String>(
          hintText: pa?.specialization ?? '',
          items: _singleItemDropdown(pa?.specialization),
          onChanged: (val) {},
          value: _sanitize(pa?.specialization),
        ),
      ),
      SizedBox(height: AppConstants.h * 0.015),

      // Skills
      build_field_name('Skills'),
      SizedBox(height: AppConstants.h * 0.00985),
      _buildSkillsChips(pa?.skills),
      SizedBox(height: AppConstants.h * 0.015),
    ];
  }

  // ─── Company account fields (read-only) ───
  List<Widget> _buildCompanyFields(UserEntity user) {
    final ca = user.companyAccount;
    return [
      // Business Sector
      build_field_name('Business Sector'),
      SizedBox(height: AppConstants.h * 0.00985),
      IgnorePointer(
        child: DefaultDropdown<String>(
          hintText: ca?.businessSector ?? '',
          items: _singleItemDropdown(ca?.businessSector),
          onChanged: (val) {},
          value: _sanitize(ca?.businessSector),
        ),
      ),
      SizedBox(height: AppConstants.h * 0.015),

      // Tax number
      build_field_name('Tax number'),
      SizedBox(height: AppConstants.h * 0.00985),
      CustomTextFormField(
        label: 'Tax number',
        hint: '',
        controller: TextEditingController(text: ca?.taxNumber ?? ''),
        readOnly: true,
      ),
      SizedBox(height: AppConstants.h * 0.015),

      // Services Offered (text field)
      build_field_name('Services Offered'),
      SizedBox(height: AppConstants.h * 0.00985),
      CustomTextFormField(
        label: 'Services Offered',
        hint: '',
        controller: TextEditingController(
          text: ca?.servicesOffered?.toString() ?? '',
        ),
        readOnly: true,
      ),
      SizedBox(height: AppConstants.h * 0.015),

      // Services Offered (chips)
      build_field_name('Services Offered'),
      SizedBox(height: AppConstants.h * 0.00985),
      _buildServicesChips(ca?.servicesOffered),
      SizedBox(height: AppConstants.h * 0.015),
    ];
  }

  // ─── Header ───
  Widget _buildHeader(UserEntity user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: AppConstants.w * 0.09,
          backgroundImage: NetworkImage(
            user.profilePicture ??
                user.profileImage ??
                'https://tse3.mm.bing.net/th/id/OIP.3JdcHnVxyN3jgFtktwo-3AHaIi?rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
        ),
        SizedBox(width: AppConstants.w * 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      user.fullName.replaceAllMapped(
                        RegExp(r'([a-z])([A-Z])'),
                        (Match m) => '${m[1]} ${m[2]}',
                      ),
                      style: TextStyle(
                        fontSize: AppConstants.w * 0.043,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (user.isVerified) ...[
                    SizedBox(width: AppConstants.w * 0.01),
                    Icon(
                      Icons.verified,
                      size: AppConstants.w * 0.04,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ],
              ),
              SizedBox(height: AppConstants.h * 0.005),
              Text(
                user.jobTitle ?? user.specialization ?? '',
                style: TextStyle(
                  fontSize: AppConstants.w * 0.032,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: AppConstants.h * 0.005),
              Row(
                children: [
                  Image.asset(
                    AppImages.profileLittleIcon,
                    width: AppConstants.w * 0.035,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: AppConstants.w * 0.01),
                  Text(
                    '#${user.id}',
                    style: TextStyle(
                      fontSize: AppConstants.w * 0.032,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            UserEntity? user;
            if (state is ProfileLoaded) user = state.user;
            if (state is ProfileUpdateSuccess) user = state.user;

            return InkWell(
              onTap: user == null ? null : () => _navigateToEdit(user!),
              child: Image.asset(
                AppImages.edit,
                height: AppConstants.h * 0.030,
              ),
            );
          },
        ),
        SizedBox(width: AppConstants.w * 0.02),
      ],
    );
  }

  // ─── Skills chips ───
  Widget _buildSkillsChips(dynamic skills) {
    List<String> skillList = _dynamicToList(skills);
    if (skillList.isEmpty) {
      return Container(
        width: AppConstants.w * 0.872,
        padding: EdgeInsets.all(AppConstants.w * 0.03),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(''),
      );
    }
    return Container(
      width: AppConstants.w * 0.872,
      padding: EdgeInsets.all(AppConstants.w * 0.02),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: skillList
            .map(
              (s) => Chip(
                label: Text(
                  s,
                  style: TextStyle(fontSize: AppConstants.w * 0.032),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            )
            .toList(),
      ),
    );
  }

  // ─── Services chips ───
  Widget _buildServicesChips(dynamic services) {
    List<String> list = _dynamicToList(services);
    if (list.isEmpty) {
      return Container(
        width: AppConstants.w * 0.872,
        padding: EdgeInsets.all(AppConstants.w * 0.03),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(''),
      );
    }
    return Container(
      width: AppConstants.w * 0.872,
      padding: EdgeInsets.all(AppConstants.w * 0.02),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: list
            .map(
              (s) => Chip(
                label: Text(
                  s,
                  style: TextStyle(fontSize: AppConstants.w * 0.032),
                ),
                deleteIcon: Icon(Icons.close, size: AppConstants.w * 0.035),
                onDeleted: null, // read-only
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            )
            .toList(),
      ),
    );
  }

  // ─── Helpers ───
  String? _sanitize(String? val) {
    if (val == null || val.trim().isEmpty) return null;
    return val;
  }

  List<DropdownMenuItem<String>> _singleItemDropdown(String? value) {
    final s = _sanitize(value);
    if (s == null) return [];
    return [DropdownMenuItem(value: s, child: Text(s))];
  }

  List<String> _dynamicToList(dynamic value) {
    if (value == null) return [];
    if (value is List) return value.map((e) => e.toString()).toList();
    if (value is Map) return value.values.map((e) => e.toString()).toList();
    if (value is String && value.isNotEmpty) {
      return value
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return [];
  }

  String _isoCodeFromCountryCode(String? countryCode) {
    if (countryCode == null) return 'SA';
    // Map common dial codes to ISO codes
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
}
