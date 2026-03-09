import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/sharedWidget/defult_drop_down.dart';
import '../../../../../../../core/utils/app_constants.dart';
import '../../../../../login/presentation/widgets/widgets/login_text.dart';
import '../../../../data/models/general_jop.dart';
import '../../../manager/sign_up_bloc.dart';
import '../../../manager/sign_up_events.dart';
import '../../../manager/sign_up_states.dart';

class BuildRelatedJob extends StatelessWidget {
  const BuildRelatedJob({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (prev, curr) =>
      prev.selectedGeneralJob != curr.selectedGeneralJob ||
          prev.selectedRelatedJob != curr.selectedRelatedJob,
      builder: (context, state) {
        // ✅ Check if general job is selected
        final isGeneralJobSelected = state.selectedGeneralJob != null;
        final relatedJobs = isGeneralJobSelected
            ? state.selectedGeneralJob!.relatedJobs
            : <RelatedJobModel>[];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Field label with visual indicator

                build_field_name('Specialization'),

            SizedBox(height: AppConstants.h * 0.01),

            // Dropdown - disabled when no general job selected
            Opacity(
              opacity: isGeneralJobSelected ? 1.0 : 0.5,
              child: AbsorbPointer(
                absorbing: !isGeneralJobSelected, // ⛔ Block interaction
                child: DefaultDropdown<RelatedJobModel>(
                  hintText: isGeneralJobSelected
                      ? 'Choose specialization'
                      : 'Select general job first',
                  items: relatedJobs
                      .map(
                        (job) => DropdownMenuItem<RelatedJobModel>(
                      value: job,
                      child: Text(job.name),
                    ),
                  )
                      .toList(),
                  value: isGeneralJobSelected &&
                      relatedJobs.any((j) => j == state.selectedRelatedJob)
                      ? state.selectedRelatedJob
                      : null,
                  onChanged: isGeneralJobSelected
                      ? (value) {
                    if (value != null) {
                      context
                          .read<SignUpBloc>()
                          .add(SelectRelatedJobEvent(value));
                    }
                  }
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }
}