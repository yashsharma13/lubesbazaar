// import 'package:flutter/material.dart';

// class AppColors {
// static const Color primary = Colors.orange;
// static const Color secondary = Colors.black87;
// static const Color background = Color(0xFFF5F5F5);
//   static const Color white = Colors.white;
//   static const Color error = Colors.red;
// }

import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.orange;
  static const Color secondary = Colors.black87;
  static const Color white = Colors.white;
  static const Color background = Color(0xFFF5F5F5);
  static const Color primaryDark = Color(0xFF072987);
  static const Color primaryLight = Color(0xFF4298ED);
  static const Color grey = Colors.grey;
  static const Color greyLight = Color(0xFFE0E0E0); // Light grey
  static const Color green = Colors.green; // Light grey
  static const Color red = Colors.red;

  // Gradient List (for buttons, backgrounds etc.)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryDark, primaryLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
