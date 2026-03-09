import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/sharedWidget/defult_drop_down.dart';
import '../../../../../../../core/utils/app_constants.dart';
import '../../../../../../../core/utils/app_texts.dart';
import '../../../../../login/presentation/widgets/widgets/login_text.dart';
 import '../../../../data/models/busnuess.dart';
import '../../../manager/sign_up_bloc.dart';
import '../../../manager/sign_up_events.dart';
import '../../../manager/sign_up_states.dart';

class BuildBusinessSector extends StatelessWidget {
  const BuildBusinessSector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (prev, curr) =>
      prev.selectedBusinessSector != curr.selectedBusinessSector,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            build_field_name('Business Sector'),
            SizedBox(height: AppConstants.h*0.01),

            DefaultDropdown<BusinessSectorModel>(
              hintText: 'Choose business sector',

              items: businessSectorsList
                  .map(
                    (sector) => DropdownMenuItem<BusinessSectorModel>(
                  value: sector,
                  child: Text(
                    sector.name,
                    style: AppTextStyles.bodyMedium(),
                  ),
                ),
              )
                  .toList(),

              /// ✅ SAFE VALUE
              value: businessSectorsList.any(
                    (s) => s == state.selectedBusinessSector,
              )
                  ? state.selectedBusinessSector
                  : null,

              onChanged: (value) {
                if (value != null) {
                  context
                      .read<SignUpBloc>()
                      .add(SelectBusinessSectorEvent(value));
                }
              },
            ),

           ],
        );
      },
    );
  }
}
