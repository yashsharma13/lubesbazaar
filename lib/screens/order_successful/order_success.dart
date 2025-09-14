import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/app_routes.dart';
import 'package:lubes_bazaar/config/styles.dart';
import 'package:lubes_bazaar/widgets/custom_button.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Lottie Animation
            Lottie.asset(
              'assets/animation/success.json',
              width: 200,
              height: 200,
              repeat: true,
            ),

            const SizedBox(height: AppSpacing.md),

            // ✅ Success Text
            Text(
              "Order Placed Successfully 🎉",
              style: AppTextStyles.heading.copyWith(color: AppColors.green),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.xl),

            // ✅ Custom Button
            CustomButton(
              text: "Back to Home",
              useGradient: true,
              height: 45,
              width: 180,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home, // 👈 custom route
                  (route) => false, // ✅ clear backstack
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
