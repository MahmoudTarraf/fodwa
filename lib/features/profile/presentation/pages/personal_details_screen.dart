import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/features/profile/domain/entities/user_entity.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_cubit.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_state.dart';
import 'package:fodwa/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:fodwa/core/sharedWidget/field.dart';
import 'package:fodwa/core/sharedWidget/defult_drop_down.dart';
import 'package:fodwa/core/intialization/initiDI.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppConstants.initSize(context);
    
    return BlocProvider.value(
      value: getIt<ProfileCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: AppConstants.w * 0.064),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Personal Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: AppConstants.w * 0.048,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.edit_square, color: const Color(0xFF6B7280)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              );
            },
          ),
          SizedBox(width: AppConstants.w * 0.02),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = (state is ProfileSuccess) ? state.user : _getStaticUser();
          
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.w * 0.064,
              vertical: AppConstants.h * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(user),
                SizedBox(height: AppConstants.h * 0.02),
                Divider(color: AppColors.dividerColor, thickness: 1),
                SizedBox(height: AppConstants.h * 0.02),
                
                _buildLabel('Full Name *'),
                CustomTextFormField(
                  label: 'Full Name *',
                  hint: '',
                  controller: TextEditingController(text: user.fullName),
                  readOnly: true,
                  prefixIcon: Icons.person_outline,
                ),
                SizedBox(height: AppConstants.h * 0.02),
                
                _buildLabel('Email *'),
                CustomTextFormField(
                  label: 'Email *',
                  hint: '',
                  controller: TextEditingController(text: user.email),
                  readOnly: true,
                  prefixIcon: Icons.email_outlined,
                ),
                SizedBox(height: AppConstants.h * 0.02),
                
                _buildLabel('Phone Number'),
                // Phone number logic
                _buildPhoneField(user.countryCode, user.phoneNumber),
                SizedBox(height: AppConstants.h * 0.02),
                
                _buildLabel('Country *'),
                IgnorePointer(
                  child: DefaultDropdown<String>(
                    hintText: user.address?.country ?? '',
                    items: user.address?.country != null && user.address!.country.trim().isNotEmpty
                        ? [DropdownMenuItem(value: user.address!.country, child: Text(user.address!.country))]
                        : [],
                    onChanged: (val) {},
                    value: user.address?.country != null && user.address!.country.trim().isNotEmpty ? user.address!.country : null,
                  ),
                ),
                SizedBox(height: AppConstants.h * 0.02),
                
                _buildLabel('City'),
                IgnorePointer(
                  child: DefaultDropdown<String>(
                    hintText: user.address?.city ?? '',
                    items: user.address?.city != null && user.address!.city.trim().isNotEmpty
                        ? [DropdownMenuItem(value: user.address!.city, child: Text(user.address!.city))]
                        : [],
                    onChanged: (val) {},
                    value: user.address?.city != null && user.address!.city.trim().isNotEmpty ? user.address!.city : null,
                  ),
                ),
                SizedBox(height: AppConstants.h * 0.02),
                
                _buildLabel('Street'),
                CustomTextFormField(
                  label: 'Street',
                  hint: '',
                  controller: TextEditingController(text: user.address?.street ?? ''),
                  readOnly: true,
                ),
                SizedBox(height: AppConstants.h * 0.02),
                
                _buildLabel('Building number'),
                CustomTextFormField(
                  label: '',
                  hint: '',
                  controller: TextEditingController(text: user.address?.buildingNumber ?? ''),
                  readOnly: true,
                ),
                SizedBox(height: AppConstants.h * 0.02),
                
                _buildLabel('Apartment number'),
                CustomTextFormField(
                  label: '',
                  hint: '',
                  controller: TextEditingController(text: user.address?.apartmentNumber ?? ''),
                  readOnly: true,
                ),
                SizedBox(height: AppConstants.h * 0.02),
                
                _buildLabel('Account type *'),
                IgnorePointer(
                  child: DefaultDropdown<String>(
                    hintText: user.accountType,
                    items: user.accountType.trim().isNotEmpty 
                        ? [DropdownMenuItem(value: user.accountType, child: Text(user.accountType))]
                        : [],
                    onChanged: (val) {},
                    value: user.accountType.trim().isNotEmpty ? user.accountType : null,
                  ),
                ),
                SizedBox(height: AppConstants.h * 0.02),
                
                if (user.accountType.toLowerCase() == 'personal' || user.accountType.toLowerCase() == 'personal account')
                  ..._buildPersonalFields(user)
                else
                  ..._buildCompanyFields(user),
                  
                _buildLabel('About me'),
                Container(
                  width: AppConstants.w * 0.872,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(AppConstants.w * 0.04),
                  child: Text(
                    user.aboutMe ?? '',
                    style: TextStyle(
                      fontSize: AppConstants.w * 0.035,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: AppConstants.h * 0.05),
              ],
            ),
          );
        },
      ),
    ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppConstants.h * 0.01),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppConstants.w * 0.037,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1F2937),
        ),
      ),
    );
  }

  Widget _buildPhoneField(String? countryCode, String? phone) {
    return Container(
      width: AppConstants.w * 0.872,
      height: AppConstants.h * 0.0565,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.03),
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: Color(0xFFE5E7EB))),
            ),
            child: Row(
              children: [
                Icon(Icons.flag, size: AppConstants.w * 0.05, color: Colors.green),
                SizedBox(width: AppConstants.w * 0.01),
                Text(countryCode ?? '+966', style: TextStyle(fontSize: AppConstants.w * 0.035)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.03),
              child: Text(
                phone ?? '',
                style: TextStyle(fontSize: AppConstants.w * 0.035),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(UserEntity user) {
    return Row(
      children: [
        CircleAvatar(
          radius: AppConstants.w * 0.09,
          backgroundImage: NetworkImage(
            user.profilePicture ?? user.profileImage ?? 'https://tse3.mm.bing.net/th/id/OIP.3JdcHnVxyN3jgFtktwo-3AHaIi?rs=1&pid=ImgDetMain&o=7&rm=3',
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
                      user.fullName,
                      style: TextStyle(
                        fontSize: AppConstants.w * 0.043,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: AppConstants.w * 0.01),
                  Icon(Icons.verified, size: AppConstants.w * 0.04, color: AppColors.primaryColor),
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
                  Icon(Icons.person_outline, size: AppConstants.w * 0.035, color: AppColors.primaryColor),
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
      ],
    );
  }

  List<Widget> _buildPersonalFields(UserEntity user) {
    return [
      _buildLabel('Gender'),
      IgnorePointer(
        child: DefaultDropdown<String>(
          hintText: user.personalAccount?.gender ?? '',
          items: user.personalAccount?.gender != null && user.personalAccount!.gender!.trim().isNotEmpty
              ? [DropdownMenuItem(value: user.personalAccount!.gender, child: Text(user.personalAccount!.gender!))]
              : [],
          onChanged: (val) {},
          value: user.personalAccount?.gender != null && user.personalAccount!.gender!.trim().isNotEmpty ? user.personalAccount!.gender : null,
        ),
      ),
      SizedBox(height: AppConstants.h * 0.02),
      
      _buildLabel('Date of birth'),
      CustomTextFormField(
        label: '',
        hint: '',
        controller: TextEditingController(text: user.personalAccount?.dateOfBirth ?? ''),
        readOnly: true,
        prefixIcon: Icons.calendar_today,
      ),
      SizedBox(height: AppConstants.h * 0.02),
      
      _buildLabel('General job'),
      IgnorePointer(
        child: DefaultDropdown<String>(
           hintText: user.personalAccount?.generalJob ?? '',
           items: user.personalAccount?.generalJob != null && user.personalAccount!.generalJob!.trim().isNotEmpty
              ? [DropdownMenuItem(value: user.personalAccount!.generalJob, child: Text(user.personalAccount!.generalJob!))]
              : [],
           onChanged: (val) {},
           value: user.personalAccount?.generalJob != null && user.personalAccount!.generalJob!.trim().isNotEmpty ? user.personalAccount!.generalJob : null,
        ),
      ),
      SizedBox(height: AppConstants.h * 0.02),
      
      _buildLabel('Specialization'),
      IgnorePointer(
        child: DefaultDropdown<String>(
           hintText: user.personalAccount?.specialization ?? '',
           items: user.personalAccount?.specialization != null && user.personalAccount!.specialization!.trim().isNotEmpty
              ? [DropdownMenuItem(value: user.personalAccount!.specialization, child: Text(user.personalAccount!.specialization!))]
              : [],
           onChanged: (val) {},
           value: user.personalAccount?.specialization != null && user.personalAccount!.specialization!.trim().isNotEmpty ? user.personalAccount!.specialization : null,
        ),
      ),
      SizedBox(height: AppConstants.h * 0.02),
      
      _buildLabel('Skills'),
      Container(
        width: AppConstants.w * 0.872,
        padding: EdgeInsets.all(AppConstants.w * 0.03),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(user.personalAccount?.skills?.toString() ?? ''),
      ),
      SizedBox(height: AppConstants.h * 0.02),
    ];
  }

  List<Widget> _buildCompanyFields(UserEntity user) {
    return [
      _buildLabel('Business Sector'),
      IgnorePointer(
        child: DefaultDropdown<String>(
          hintText: user.companyAccount?.businessSector ?? '',
          items: user.companyAccount?.businessSector != null && user.companyAccount!.businessSector!.trim().isNotEmpty
              ? [DropdownMenuItem(value: user.companyAccount!.businessSector, child: Text(user.companyAccount!.businessSector!))]
              : [],
          onChanged: (val) {},
          value: user.companyAccount?.businessSector != null && user.companyAccount!.businessSector!.trim().isNotEmpty ? user.companyAccount!.businessSector : null,
        ),
      ),
      SizedBox(height: AppConstants.h * 0.02),
      
      _buildLabel('Tax number'),
      CustomTextFormField(
        label: '',
        hint: '',
        controller: TextEditingController(text: user.companyAccount?.taxNumber ?? ''),
        readOnly: true,
      ),
      SizedBox(height: AppConstants.h * 0.02),
      
      _buildLabel('Services Offered'),
      Container(
        width: AppConstants.w * 0.872,
        padding: EdgeInsets.all(AppConstants.w * 0.03),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(user.companyAccount?.servicesOffered?.toString() ?? ''),
      ),
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
