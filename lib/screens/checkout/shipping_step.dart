import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/styles.dart';
import 'package:lubes_bazaar/widgets/custom_dropdown.dart';
import 'package:lubes_bazaar/widgets/custom_text_field.dart';

class ShippingStep extends StatefulWidget {
  const ShippingStep({super.key});

  @override
  State<ShippingStep> createState() => _ShippingStepState();
}

class _ShippingStepState extends State<ShippingStep> {
  int selectedIndex = 0; // 0 = New Address, 1 = Saved Address

  // Controllers
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController zipCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),

        // ✅ Toggle Buttons
        Row(
          children: [
            Expanded(child: buildToggleButton("New Address", 0)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: buildToggleButton("Saved Address", 1)),
          ],
        ),

        const SizedBox(height: AppSpacing.lg),

        // ✅ First Name & Last Name
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                hint: "First Name*",
                controller: firstNameCtrl,
                validator: (val) =>
                    val == null || val.isEmpty ? "Required" : null,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: CustomTextField(
                hint: "Last Name*",
                controller: lastNameCtrl,
                validator: (val) =>
                    val == null || val.isEmpty ? "Required" : null,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),
        CustomTextField(hint: "Address", controller: addressCtrl),

        const SizedBox(height: AppSpacing.md),
        CustomTextField(
          hint: "Phone Number",
          controller: phoneCtrl,
          validator: (val) =>
              val == null || val.length < 10 ? "Enter valid phone" : null,
        ),

        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: CustomDropdown(
                hint: "City",
                items: ["Malaysia", "India", "USA"],
                onChanged: (val) => debugPrint("Selected City: $val"),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: CustomDropdown(
                hint: "State",
                items: ["Malaysia", "Gujarat", "Texas"],
                onChanged: (val) => debugPrint("Selected State: $val"),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: CustomDropdown(
                hint: "Country",
                items: ["Malaysia", "India", "USA"],
                onChanged: (val) => debugPrint("Selected Country: $val"),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: CustomTextField(hint: "Zip Code", controller: zipCtrl),
            ),
          ],
        ),
      ],
    );
  }

  /// ✅ Reusable Toggle Button
  Widget buildToggleButton(String text, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey, width: 1.2),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTextStyles.buttonText.copyWith(
            color: isSelected ? Colors.white : AppColors.grey,
          ),
        ),
      ),
    );
  }
}
