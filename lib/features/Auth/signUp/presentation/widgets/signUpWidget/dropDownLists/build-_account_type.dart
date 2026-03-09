import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/core/utils/app_constants.dart';

import '../../../../../../../core/sharedWidget/defult_drop_down.dart';
import '../../../../../../../core/utils/app_texts.dart';
import '../../../../../login/presentation/widgets/widgets/login_text.dart';
import '../../../../data/models/account_type.dart';
import '../../../manager/sign_up_bloc.dart';
import '../../../manager/sign_up_events.dart';

class BuildAccType extends StatelessWidget {
  const BuildAccType({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        build_field_name('Account Type *'),
        SizedBox(height: AppConstants.h * 0.01),

        DefaultDropdown<AccountType>(
          hintText: AccountType.personal.name,
          value: context.watch<SignUpBloc>().state.accountType,
          items: AccountType.values
              .map(
                (type) => DropdownMenuItem<AccountType>(
                  value: type,
                  child: Text(type.label, style: AppTextStyles.bodyMedium()),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              context.read<SignUpBloc>().add(SelectAccountTypeEvent(value));
            }
          },
        ),
      ],
    );
  }
}
