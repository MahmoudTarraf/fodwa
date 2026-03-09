import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_constants.dart';

build_profile_decoration(
    Widget childWidget, {
      double? height,
    }) {
  return Container(
    width: AppConstants.w * 0.992, // 372 / 375
    height: height,
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.064, // 24 / 375
      ),
      child: Material(
        elevation: AppConstants.h * 0.0005, // 1 / 812
        borderRadius: BorderRadius.circular(
          AppConstants.w * 0.0213, // 8 / 375
        ),
        color: Colors.white,
        child: childWidget,
      ),
    ),
  );
}
