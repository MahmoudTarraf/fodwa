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
  final List<String>? selectedSkills;
  final ValueChanged<String>? onAddSkill;
  final ValueChanged<String>? onRemoveSkill;

  const BuildSkillsSelector({
    super.key,
    this.selectedSkills,
    this.onAddSkill,
    this.onRemoveSkill,
  });

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

  void _addSkill(BuildContext context, String skill) {
    if (widget.onAddSkill != null) {
      widget.onAddSkill!(skill);
    } else {
      context.read<SignUpBloc>().add(AddSkillEvent(skill));
    }
  }

  void _removeSkill(BuildContext context, String skill) {
    if (widget.onRemoveSkill != null) {
      widget.onRemoveSkill!(skill);
    } else {
      context.read<SignUpBloc>().add(RemoveSkillEvent(skill));
    }
  }

  @override
  Widget build(BuildContext context) {
    AppConstants.initSize(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        build_field_name("Skills"),

        /// Selected Skills
        if (widget.selectedSkills != null)
          _buildSkillsList(context, widget.selectedSkills!)
        else
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              return _buildSkillsList(context, state.selectedSkills);
            },
          ),

        SizedBox(height: AppConstants.h * 0.0098),

        /// Dropdown
        DefaultDropdown<String>(
          hintText: 'Select a skill',
          items: skillsList.map((skill) {
            return DropdownMenuItem(value: skill.name, child: Text(skill.name));
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              _addSkill(context, value);
            }
          },
        ),

        SizedBox(height: AppConstants.h * 0.0148),

        /// Custom Skill
        Row(
          children: [
            Expanded(
              child: Container(
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
                      horizontal: AppConstants.w * 0.032,
                      vertical: AppConstants.h * 0.0172,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.w * 0.0213),
                      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.w * 0.0213),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor, // Changed redAccent to primary
                        width: AppConstants.w * 0.0032,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: AppConstants.w * 0.0213),
            SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  if (_customSkillController.text.trim().isNotEmpty) {
                    _addSkill(context, _customSkillController.text.trim());
                    _customSkillController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.w * 0.0213),
                  ),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillsList(BuildContext context, List<String> skills) {
    if (skills.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: AppConstants.w * 0.0213,
      runSpacing: AppConstants.h * 0.0098,
      children: skills.map((skill) {
        return Chip(
          label: Text(skill),
          deleteIcon: Icon(Icons.close, size: AppConstants.w * 0.048),
          onDeleted: () => _removeSkill(context, skill),
          backgroundColor: Colors.grey[200],
        );
      }).toList(),
    );
  }
}
