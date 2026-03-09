import 'package:flutter/cupertino.dart';

import '../signUpWidget/dropDownLists/build_gender.dart';
import '../signUpWidget/dropDownLists/build_general_jop.dart';
import '../signUpWidget/dropDownLists/build_skills.dart';
import '../signUpWidget/dropDownLists/date_birth.dart';
import '../signUpWidget/dropDownLists/special_jop.dart';

class PersonalAcc extends StatelessWidget {
  const PersonalAcc({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildGender(),
        DateOfBirthPicker(),
        BuildGeneralJob(),
        BuildRelatedJob(),
        BuildSkillsSelector(),
      ],
    );
  }
}
