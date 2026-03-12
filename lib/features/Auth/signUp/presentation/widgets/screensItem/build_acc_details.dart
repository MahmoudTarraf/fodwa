import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/features/Auth/signUp/presentation/widgets/screensItem/personal_acc.dart';

import '../../../data/models/account_type.dart';
import '../../manager/sign_up_bloc.dart';
import '../../manager/sign_up_states.dart';
import 'company_acc.dart';

// ignore: must_be_immutable
class BuildAccountDetails extends StatelessWidget {
  BuildAccountDetails({
    super.key,
    required this.taxNumberController,
    required this.servicesOfferedController,
  });

  TextEditingController taxNumberController;
  final TextEditingController servicesOfferedController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (prev, curr) => prev.accountType != curr.accountType,
      builder: (context, state) {
        if (state.accountType == AccountType.company) {
          return CompanyAcc(
            taxNumberController: taxNumberController,
            servicesOfferedController: servicesOfferedController,
          );
        }
        return const PersonalAcc();
      },
    );
  }
}
