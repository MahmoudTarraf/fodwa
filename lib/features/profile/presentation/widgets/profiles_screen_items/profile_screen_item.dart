import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_texts.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_cubit.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_state.dart';
import '../../../../../config/routes/app_router.dart';
import '../../../../../core/utils/app_colors.dart';
import '../profile_widget/build_logout.dart';
import '../profile_widget/build_privacy.dart';
import '../profile_widget/build_section_header.dart';
import '../profile_widget/build_setting_section.dart';
import '../profile_widget/profile_information.dart';
import '../profile_widget/build_my_accounts_as.dart';
import '../profile_widget/build_how_to_be.dart';
import 'package:fodwa/features/profile/domain/entities/user_entity.dart';

class ProfileScreenItem extends StatefulWidget {
  const ProfileScreenItem({super.key});

  @override
  State<ProfileScreenItem> createState() => _ProfileScreenItemState();
}

class _ProfileScreenItemState extends State<ProfileScreenItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoutes.bottomNav, (route) => false);
          },
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
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
          } else if (state is ProfileError || state is ProfileSuccess) {
            final user = (state is ProfileSuccess)
                ? state.user
                : _getStaticUser();
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: AppConstants.h * 0.03),
                  _buildProfileImage(user.profilePicture ?? user.profileImage),
                  SizedBox(height: AppConstants.h * 0.0067),
                  _buildUserData(user.fullName),
                  SizedBox(height: AppConstants.h * 0.0017),
                  _buildUserJob(
                    user.jobTitle ?? user.specialization ?? 'No Job Specified',
                  ),
                  SizedBox(height: AppConstants.h * 0.0067),
                  Container(
                    color: const Color(0xFFF9FAFB),
                    child: Column(
                      children: [
                        SizedBox(height: AppConstants.h * 0.0067),
                        const SectionHeader(title: 'Profile Information'),
                        SizedBox(height: AppConstants.h * 0.0067),
                        const ProfileInformation(),
                        SizedBox(height: AppConstants.h * 0.0133),
                        const SectionHeader(title: 'My Accounts as'),
                        SizedBox(height: AppConstants.h * 0.0067),
                        const BuildMyAccountsAs(),
                        SizedBox(height: AppConstants.h * 0.0133),
                        const SectionHeader(title: 'Settings'),
                        SizedBox(height: AppConstants.h * 0.0067),
                        const BuildSettingSection(),
                        SizedBox(height: AppConstants.h * 0.0133),
                        const SectionHeader(title: 'Privacy'),
                        SizedBox(height: AppConstants.h * 0.0067),
                        const BuildPrivacy(),
                        SizedBox(height: AppConstants.h * 0.0133),
                        const SectionHeader(title: 'How to BE ?'),
                        SizedBox(height: AppConstants.h * 0.0067),
                        const BuildHowToBe(),
                        SizedBox(height: AppConstants.h * 0.0317),
                        const BuildLogout(),
                        SizedBox(height: AppConstants.h * 0.16),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Initial State'));
        },
      ),
    );
  }

  Widget _buildUserJob(String job) {
    return Text(
      job,
      style: AppTextStyles.titleMedium().copyWith(
        fontWeight: FontWeight.w400,
        color: const Color(0xFF78828A),
        letterSpacing: 0,
        fontSize: AppConstants.w * 0.0373,
      ),
    );
  }

  Widget _buildProfileImage(String? imageUrl) {
    return SizedBox(
      width: AppConstants.w * 0.213,
      height: AppConstants.w * 0.213,
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          imageUrl ??
              'https://tse3.mm.bing.net/th/id/OIP.3JdcHnVxyN3jgFtktwo-3AHaIi?rs=1&pid=ImgDetMain&o=7&rm=3',
        ),
      ),
    );
  }

  Widget _buildUserData(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            name,
            style: AppTextStyles.headlineSmall().copyWith(
              fontWeight: FontWeight.w500,
              fontSize: AppConstants.w * 0.045,
              letterSpacing: 0,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: AppConstants.w * 0.016),
        Icon(Icons.verified, size: 15, color: AppColors.primaryColor),
      ],
    );
  }

  UserEntity _getStaticUser() {
    return UserEntity(
      id: '0',
      email: 'user@example.com',
      fullName: 'Default User',
      accountType: 'personal',
      profilePicture: null,
      specialization: 'Developer',
    );
  }
}
