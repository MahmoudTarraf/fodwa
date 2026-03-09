import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';

class FloatingAddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingAddButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5), // Border رمادي
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color:AppColors.primaryColor, // أحمر
            shape: BoxShape.circle,

          ),
          child: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.add, color: Colors.white, size: 35),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
