import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/core/utils/app_colors.dart';

import '../../../../../../../core/utils/app_constants.dart';
import '../../../../../login/presentation/widgets/widgets/login_text.dart';
import '../../../../data/models/busnuess.dart';
import '../../../manager/sign_up_bloc.dart';
import '../../../manager/sign_up_events.dart';
import '../../../manager/sign_up_states.dart' show SignUpState;

class BuildServicesOfferedSelector extends StatefulWidget {
  const BuildServicesOfferedSelector({super.key});

  @override
  State<BuildServicesOfferedSelector> createState() =>
      _BuildServicesOfferedSelectorState();
}

class _BuildServicesOfferedSelectorState
    extends State<BuildServicesOfferedSelector> {
  final TextEditingController _customServiceController =
      TextEditingController();

  @override
  void dispose() {
    _customServiceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // init size (375 × 812)
    AppConstants.initSize(context);

    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        final sector = state.selectedBusinessSector;

        final filteredServices = sector == null
            ? []
            : servicesList.where((s) => s.sectorId == sector.id).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            build_field_name('Services Offered'),

            SizedBox(
              height: AppConstants.h * 0.0098, // 8 / 812
            ),

            /// Selected services
            Wrap(
              spacing: AppConstants.w * 0.0213, // 8 / 375
              runSpacing: AppConstants.h * 0.0098, // 8 / 812
              children: state.selectedServices.map((service) {
                return Chip(
                  label: Text(service),
                  deleteIcon: Icon(
                    Icons.close,
                    size: AppConstants.w * 0.048, // 18 / 375
                  ),
                  onDeleted: () {
                    context.read<SignUpBloc>().add(RemoveServiceEvent(service));
                  },
                );
              }).toList(),
            ),

            SizedBox(
              height: AppConstants.h * 0.0148, // 12 / 812
            ),

            /// Dropdown
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.w * 0.032, // 12 / 375
              ),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD1D8DD)),
                borderRadius: BorderRadius.circular(
                  AppConstants.w * 0.0213, // 14 / 375
                ),
                color: Colors.white,
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: const SizedBox(),
                hint: Text(
                  sector == null
                      ? 'Select business sector first'
                      : 'Select a service',
                ),
                items: filteredServices
                    .map<DropdownMenuItem<String>>(
                      (service) => DropdownMenuItem<String>(
                        value: service.name,
                        child: Text(service.name),
                      ),
                    )
                    .toList(),
                onChanged: sector == null
                    ? null
                    : (value) {
                        if (value != null) {
                          context.read<SignUpBloc>().add(
                            AddServiceEvent(value),
                          );
                        }
                      },
              ),
            ),

            SizedBox(
              height: AppConstants.h * 0.0148, // 12 / 812
            ),

            /// Custom service
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _customServiceController,
                    decoration: InputDecoration(
                      hintText: 'Add custom service',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppConstants.w * 0.032, // 12 / 375
                        vertical: AppConstants.h * 0.0172, // 14 / 812
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.w * 0.0213, // 14 / 375
                        ),
                        borderSide: const BorderSide(color: Color(0xFFD1D8DD)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.w * 0.0213, // 14 / 375
                        ),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: AppConstants.w * 0.0032, // 1.2 / 375
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: AppConstants.w * 0.0213, // 8 / 375
                ),

                ElevatedButton(
                  onPressed: () {
                    if (_customServiceController.text.trim().isNotEmpty) {
                      context.read<SignUpBloc>().add(
                        AddServiceEvent(_customServiceController.text.trim()),
                      );
                      _customServiceController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.w * 0.0533, // 20 / 375
                      vertical: AppConstants.h * 0.0172, // 14 / 812
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.w * 0.0213, // 14 / 375
                      ),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppConstants.h * 0.014),
          ],
        );
      },
    );
  }
}
