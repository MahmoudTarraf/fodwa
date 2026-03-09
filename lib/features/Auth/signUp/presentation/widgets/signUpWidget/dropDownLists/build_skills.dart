import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/sharedWidget/defult_drop_down.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_constants.dart';
import '../../../../../login/presentation/widgets/widgets/login_text.dart';
import '../../../../data/models/skills_model.dart';
import '../../../manager/sign_up_bloc.dart';
import '../../../manager/sign_up_events.dart';
import '../../../manager/sign_up_states.dart';

class BuildSkillsSelector extends StatefulWidget {
  const BuildSkillsSelector({super.key});

  @override
  State<BuildSkillsSelector> createState() => _BuildSkillsSelectorState();
}

class _BuildSkillsSelectorState extends State<BuildSkillsSelector> {
  final TextEditingController _customSkillController = TextEditingController();

  @override
  void dispose() {
    _customSkillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // init size (375 × 812)
    AppConstants.initSize(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        build_field_name("Skills"),

        /// Selected Skills
        BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return Wrap(
              spacing: AppConstants.w * 0.0213, // 8 / 375
              runSpacing: AppConstants.h * 0.0098, // 8 / 812
              children: state.selectedSkills.map((skill) {
                return Chip(
                  label: Text(skill),
                  deleteIcon: Icon(
                    Icons.close,
                    size: AppConstants.w * 0.048, // 18 / 375
                  ),
                  onDeleted: () {
                    context.read<SignUpBloc>().add(RemoveSkillEvent(skill));
                  },
                  backgroundColor: Colors.grey[200],
                );
              }).toList(),
            );
          },
        ),

        SizedBox(
          height: AppConstants.h * 0.0098, // 8 / 812
        ),

        /// Dropdown
        DefaultDropdown<String>(
          hintText: 'Select a skill',
          items: skillsList.map((skill) {
            return DropdownMenuItem(value: skill.name, child: Text(skill.name));
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              context.read<SignUpBloc>().add(AddSkillEvent(value));
            }
          },
        ),

        SizedBox(
          height: AppConstants.h * 0.0148, // 12 / 812
        ),

        /// Custom Skill
        Row(
          children: [
            Expanded(
              child: Container(
                width: 327,
                height: 44,
                child: TextField(
                  controller: _customSkillController,
                  decoration: InputDecoration(
                    hintText: 'Add custom skill',
                    hintStyle: TextStyle(
                      color: const Color(0xFFE3E9ED),
                      fontSize: AppConstants.w * 0.032,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppConstants.w * 0.032, // 12 / 375
                      vertical: AppConstants.h * 0.0172, // 14 / 812
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.w * 0.0213, // 8 / 375
                      ),
                      borderSide: const BorderSide(
                        color: const Color(0xFFE5E7EB),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.w * 0.0213, // 8 / 375
                      ),
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: AppConstants.w * 0.0032, // 1.2 / 375
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              width: AppConstants.w * 0.0213, // 8 / 375
            ),

            SizedBox(
              width: AppConstants.w * 0.187, // 24 / 375
              height: AppConstants.h * 0.049, // 44 / 812
              child: ElevatedButton(
                onPressed: () {
                  if (_customSkillController.text.trim().isNotEmpty) {
                    context.read<SignUpBloc>().add(
                      AddSkillEvent(_customSkillController.text.trim()),
                    );
                    _customSkillController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.w * 0.0533, // 20 / 375
                    vertical: AppConstants.h * 0.012, // 10 / 812
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.w * 0.0213, // 8 / 375
                    ),
                  ),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
