import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/features/helpAndSupport/presentation/widgets/build_faq/build_faq_tab.dart';

import '../supportScreenItem/call_us_tap.dart';

enum SupportTabType { callUs, faq }

class BuildSupportTap extends StatefulWidget {
  const BuildSupportTap({super.key});

  @override
  State<BuildSupportTap> createState() => _BuildSupportTapState();
}

class _BuildSupportTapState extends State<BuildSupportTap> {
  SupportTabType _selectedTab = SupportTabType.callUs;

  void _onTabSelected(SupportTabType tab) {
    if (_selectedTab == tab) return;
    setState(() => _selectedTab = tab);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(color: Color(0XFFEDEDED), width: double.infinity, height: 4),
        SizedBox(height: AppConstants.h * 0.015),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.064),
          child: Row(
            children: [
              SupportTabItem(
                title: 'Call Us',
                isSelected: _selectedTab == SupportTabType.callUs,
                activeColor: AppColors.primaryColor,
                onTap: () => _onTabSelected(SupportTabType.callUs),
              ),
              SupportTabItem(
                title: 'FAQ',
                isSelected: _selectedTab == SupportTabType.faq,
                activeColor: AppColors.primaryColor,
                onTap: () => _onTabSelected(SupportTabType.faq),
              ),
            ],
          ),
        ),
        SizedBox(height: AppConstants.h * 0.015),
        Container(color: Color(0XFFEDEDED), width: double.infinity, height: 4),
        _selectedTab == SupportTabType.callUs ? CallUsTap() : FAQScreen(),
      ],
    );
  }
}

class SupportTabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Color activeColor;
  final VoidCallback onTap;

  const SupportTabItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 31,
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF66707A),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
