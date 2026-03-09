import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/sharedWidget/defult_drop_down.dart';
import '../../../../../../../core/utils/app_constants.dart';
import '../../../../../../../core/utils/app_texts.dart';
import '../../../../../login/presentation/widgets/widgets/login_text.dart';
import '../../../manager/sign_up_bloc.dart';
import '../../../manager/sign_up_events.dart';
import '../../../../data/models/gender.dart';

class BuildGender extends StatelessWidget {
  const BuildGender({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        build_field_name('Gender'),
        SizedBox(height: AppConstants.h * 0.01),

        DefaultDropdown<Gender>(
          hintText: 'Choose gender',
          value: context.watch<SignUpBloc>().state.gender,
          items: Gender.values
              .map(
                (g) => DropdownMenuItem<Gender>(
                  value: g,
                  child: Text(g.label, style: AppTextStyles.bodyMedium()),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              context.read<SignUpBloc>().add(SelectGenderEvent(value));
            }
          },
        ),
      ],
    );
  }
}
