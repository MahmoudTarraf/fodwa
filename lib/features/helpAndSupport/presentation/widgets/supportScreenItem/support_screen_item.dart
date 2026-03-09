import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fodwa/core/utils/app_colors.dart';

import '../supportWidgets/build_support_tap.dart';

class HelpSupportScreenItem extends StatefulWidget {
  const HelpSupportScreenItem({Key? key}) : super(key: key);

  @override
  State<HelpSupportScreenItem> createState() => _HelpSupportScreenItemState();
}

class _HelpSupportScreenItemState extends State<HelpSupportScreenItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: AppBar(
        toolbarHeight: 55,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: AppColors.screenBg,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.blackPrimaryColor,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 1,
        title: const Text(
          'Help & Support',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tabs
            BuildSupportTap(),

            // Content
          ],
        ),
      ),
    );
  }
}
