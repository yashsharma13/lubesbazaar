import 'package:flutter/material.dart';
import 'app_colors.dart';

/// ✅ Text Styles
class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryDark,
  );

  static const TextStyle authTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.secondary,
  );

  static const TextStyle link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const TextStyle emptyState = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  static const TextStyle cartTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryDark,
  );

  static const TextStyle cartSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.secondary,
  );

  /// ✅ Checkout Stepper Tabs
  static TextStyle checkoutTab(bool isActive, bool isCompleted) => TextStyle(
    color: isActive || isCompleted ? AppColors.primaryDark : Colors.grey,
    fontWeight: isActive
        ? FontWeight.bold
        : isCompleted
        ? FontWeight.w500
        : FontWeight.normal,
  );
}

/// ✅ Spacing Constants
class AppSpacing {
  static const double xs = 6.0;
  static const double sm = 10.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
}

/// ✅ Padding Helpers
class AppPadding {
  static const EdgeInsets screen = EdgeInsets.all(AppSpacing.md);
  static const EdgeInsets form = EdgeInsets.symmetric(
    horizontal: AppSpacing.lg,
  );
}

/// ✅ Card Decorations
class AppDecorations {
  static BoxDecoration card = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );
}

/// ✅ Logo Styles
class AppLogoStyles {
  static const double height = 160;
  static const EdgeInsets margin = EdgeInsets.only(top: 50, bottom: 20);
}

/// ✅ AppDropdownStyles Styles
class AppDropdownStyles {
  static final InputDecoration inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.grey),
    ),
  );

  static final BoxDecoration dropdownDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ],
  );

  static const TextStyle itemTextStyle = TextStyle(
    fontSize: 14,
    color: AppColors.secondary,
  );

  static const TextStyle hintTextStyle = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );
}

/// ✅ Search Styles
class AppSearchStyles {
  static final InputDecoration searchInputDecoration = InputDecoration(
    hintText: "Search for products",
    hintStyle: AppTextStyles.body.copyWith(color: AppColors.grey),
    prefixIcon: const Icon(Icons.search, color: AppColors.grey),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.grey),
    ),
  );
}

/// ✅ Responsive helper
class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
}
