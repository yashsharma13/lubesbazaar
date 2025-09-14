import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/styles.dart';

class PaymentStep extends StatelessWidget {
  final String selectedPayment;
  final Function(String) onPaymentChanged;

  const PaymentStep({
    super.key,
    required this.selectedPayment,
    required this.onPaymentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),

        // ✅ Title
        Text(
          "Select a payment method",
          style: AppTextStyles.heading.copyWith(fontSize: 18),
        ),
        const SizedBox(height: AppSpacing.md),

        // ✅ Payment Options
        Container(
          decoration: AppDecorations.card,
          child: Column(
            children: [
              buildOption("QuickPay", Icons.flash_on, Colors.orange),
              buildOption("DebitCard", Icons.credit_card, Colors.blueGrey),
              buildOption(
                "CreditCard",
                Icons.credit_card_outlined,
                Colors.blue,
              ),
              buildOption("NetBanking", Icons.account_balance, Colors.green),
              buildOption(
                "Wallet",
                Icons.account_balance_wallet,
                Colors.purple,
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // ✅ Total Amount
        Container(
          decoration: AppDecorations.card,
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Amount", style: AppTextStyles.cartSubtitle),
              Text(
                "₹ 12,495",
                style: AppTextStyles.cartTitle.copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildOption(String value, IconData icon, Color color) {
    return RadioListTile(
      value: value,
      groupValue: selectedPayment,
      onChanged: (val) => onPaymentChanged(val.toString()),
      activeColor: AppColors.primary,
      title: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: AppSpacing.sm),
          Text(
            value.replaceAll("Card", " Card").replaceAll("Net", "Net "),
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}
