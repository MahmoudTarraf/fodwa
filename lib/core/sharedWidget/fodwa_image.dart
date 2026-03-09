
import 'package:flutter/cupertino.dart';

import '../utils/app_constants.dart';
import '../utils/app_images.dart';

Widget buildFodwaAuthImage({
  double? width,
  double? height,
  BoxFit? fit,
}) {
  return Image.asset(
    AppImages.fodwaName,
    width: width ?? AppConstants.w * 0.48,
    height: height ?? AppConstants.h * 0.073,
    fit: fit??BoxFit.contain,
   );
}


Widget buildFodwaLogo({
  double? width,
  double? height,
  BoxFit? fit,

})  {
  return Image.asset(
    AppImages.logo,
    width: width ??
        AppConstants.w * 0.47,   // 180 / 375
    height: height ??AppConstants.h * 0.07, // 59 / 812
    fit: fit??BoxFit.contain,
  );
}

