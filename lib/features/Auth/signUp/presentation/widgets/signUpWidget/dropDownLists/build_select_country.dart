import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/sharedWidget/defult_drop_down.dart';
import '../../../../../../../generated/locale_keys.g.dart';
import '../../../../../login/presentation/widgets/widgets/login_text.dart';
import '../../../../data/models/country_model.dart';
import '../../../manager/sign_up_bloc.dart' show SignUpBloc;
import '../../../manager/sign_up_events.dart';
import '../../../manager/sign_up_states.dart';

class BuildSelectCountry extends StatelessWidget {
  const BuildSelectCountry({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (prev, curr) => prev.selectedCountry != curr.selectedCountry,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            build_field_name(LocaleKeys.auth_country.tr()),
            const SizedBox(height: 8),
            DefaultDropdown<CountryModel>(
              hintText: "Choose Country",
              items: countriesList
                  .map(
                    (c) => DropdownMenuItem<CountryModel>(
                      value: c,
                      child: Text(c.name),
                    ),
                  )
                  .toList(),
              value: state.selectedCountry,
              onChanged: (value) {
                if (value != null) {
                  context.read<SignUpBloc>().add(SelectCountryEvent(value));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
