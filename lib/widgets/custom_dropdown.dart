import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:lubes_bazaar/config/styles.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.items,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField2<String>(
        value: value,
        decoration: AppDropdownStyles.inputDecoration.copyWith(
          hintText: hint,
          hintStyle: AppDropdownStyles.hintTextStyle,
        ),
        isExpanded: true,
        style: AppDropdownStyles.itemTextStyle,
        items: items
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e, style: AppDropdownStyles.itemTextStyle),
              ),
            )
            .toList(),
        onChanged: onChanged,
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: AppDropdownStyles.dropdownDecoration,
          offset: const Offset(0, -5),
        ),
      ),
    );
  }
}
