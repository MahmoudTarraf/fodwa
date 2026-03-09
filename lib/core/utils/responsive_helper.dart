import 'package:flutter/widgets.dart';

class ResponsiveHelper {
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  
  // Converts a pixel value designed for 375px width screen to proportional width
  static double proportionalWidth(BuildContext context, double pixels) {
    return (pixels / 375.0) * width(context);
  }

  // Converts a pixel value designed for 812px height screen to proportional height
  static double proportionalHeight(BuildContext context, double pixels) {
    return (pixels / 812.0) * height(context);
  }
}
