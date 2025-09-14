import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/styles.dart';
import 'package:lubes_bazaar/screens/order_successful/order_success.dart';
import 'package:lubes_bazaar/widgets/custom_appbar.dart';
import 'package:lubes_bazaar/widgets/custom_button.dart';
import 'package:lubes_bazaar/widgets/sidebar.dart';
import 'shipping_step.dart';
import 'payment_step.dart';
import 'confirmation_step.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int currentStep = 0;
  String selectedPayment = "CreditCard";

  void nextStep() {
    if (currentStep < 2) {
      setState(() => currentStep++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OrderSuccessPage()),
      );
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  Widget buildStepTabs() {
    final tabs = ["Shipping", "Payment", "Confirmation"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(tabs.length, (index) {
        final isActive = currentStep == index;
        final isCompleted = index < currentStep;

        return Column(
          children: [
            Row(
              children: [
                if (isCompleted)
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.green,
                    size: 20,
                  )
                else
                  Icon(
                    Icons.radio_button_checked,
                    color: isActive ? AppColors.green : Colors.grey,
                    size: 20,
                  ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  tabs[index],
                  style: AppTextStyles.checkoutTab(isActive, isCompleted),
                ),
              ],
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: AppSpacing.xs),
                height: 3,
                width: 50,
                color: AppColors.primaryLight,
              ),
          ],
        );
      }),
    );
  }

  Widget buildStepContent() {
    if (currentStep == 0) return const ShippingStep();
    if (currentStep == 1) {
      return PaymentStep(
        selectedPayment: selectedPayment,
        onPaymentChanged: (val) {
          setState(() => selectedPayment = val);
        },
      );
    }
    return const ConfirmationStep();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "CHECKOUT", useGradient: true),
      drawer: const Sidebar(),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screen.copyWith(bottom: AppSpacing.lg + 20),
          child: Column(
            children: [
              buildStepTabs(),
              const SizedBox(height: AppSpacing.lg),
              Expanded(child: SingleChildScrollView(child: buildStepContent())),
              const SizedBox(height: AppSpacing.lg),

              // Buttons
              Row(
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: CustomButton(
                        text: "Back",
                        onPressed: previousStep,
                        useGradient: true,
                      ),
                    ),
                  if (currentStep > 0) const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: CustomButton(
                      text: currentStep == 2 ? "Order Now" : "Continue",
                      onPressed: nextStep,
                      useGradient: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
