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

class BuildSelectedCityWidget extends StatelessWidget {
  const BuildSelectedCityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (prev, curr) =>
          prev.selectedCountry != curr.selectedCountry ||
          prev.selectedCity != curr.selectedCity,
      builder: (context, state) {
        // ✅ Check if country is selected
        final isCountrySelected = state.selectedCountry != null;
        final cities = isCountrySelected
            ? state.selectedCountry!.cities
            : <CityModel>[];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Field label with visual indicator
            build_field_name(LocaleKeys.auth_city.tr()),

            const SizedBox(height: 8),

            // Dropdown - disabled when no country selected
            Opacity(
              opacity: isCountrySelected ? 1.0 : 0.5,
              child: AbsorbPointer(
                absorbing: !isCountrySelected, // ⛔ Block interaction
                child: DefaultDropdown<CityModel>(
                  hintText: isCountrySelected
                      ? "Choose City"
                      : "Select country first",
                  items: cities
                      .map(
                        (c) => DropdownMenuItem<CityModel>(
                          value: c,
                          child: Text(c.name),
                        ),
                      )
                      .toList(),
                  value:
                      isCountrySelected &&
                          cities.any((c) => c == state.selectedCity)
                      ? state.selectedCity
                      : null,
                  onChanged: isCountrySelected
                      ? (value) {
                          if (value != null) {
                            context.read<SignUpBloc>().add(
                              SelectCityEvent(value),
                            );
                          }
                        }
                      : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
