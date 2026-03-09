import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_images.dart';

class BuildChatAppbar extends StatefulWidget {
  const BuildChatAppbar({super.key});

  @override
  State<BuildChatAppbar> createState() => _BuildChatAppbarState();
}

class _BuildChatAppbarState extends State<BuildChatAppbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
             shape: BoxShape.circle,
          ),
          child: Image.asset(AppImages.bot,
            width: 24,
          ),
        ),
        const SizedBox(width: 4),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Support Assistant',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  letterSpacing: 0,
                  fontSize: 14,

                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Online now',
                style: TextStyle(
                  color: Color(0xFFCE1126),
                  fontSize: 12,
                  letterSpacing:0,

                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
