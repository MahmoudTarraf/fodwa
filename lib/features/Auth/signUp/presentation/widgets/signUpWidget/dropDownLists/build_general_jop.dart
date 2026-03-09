import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/sharedWidget/defult_drop_down.dart';
import '../../../../../../../core/utils/app_constants.dart';
import '../../../../../../../core/utils/app_texts.dart';
import '../../../../../login/presentation/widgets/widgets/login_text.dart';
import '../../../../data/models/general_jop.dart';
import '../../../manager/sign_up_bloc.dart';
import '../../../manager/sign_up_events.dart';

class BuildGeneralJob extends StatelessWidget {
  const BuildGeneralJob({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        build_field_name('General Job'),
        SizedBox(height: AppConstants.h * 0.01),

        DefaultDropdown<GeneralJobModel>(
          hintText: 'Choose job type',
          value: context.watch<SignUpBloc>().state.selectedGeneralJob,
          items: generalJobsList
              .map(
                (job) => DropdownMenuItem<GeneralJobModel>(
                  value: job,
                  child: Text(job.name, style: AppTextStyles.bodyMedium()),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              context.read<SignUpBloc>().add(SelectGeneralJobEvent(value));
            }
          },
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
