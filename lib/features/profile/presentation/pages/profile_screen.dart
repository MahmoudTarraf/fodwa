import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/core/intialization/initiDI.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_cubit.dart';
import 'package:fodwa/features/profile/presentation/widgets/profiles_screen_items/profile_screen_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getProfile(),
      child: const ProfileScreenItem(),
    );
  }
}
