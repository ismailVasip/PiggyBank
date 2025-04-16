import 'package:flutter/material.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';

class AddWordField extends StatelessWidget {
  final String necessaryText;
  final String optionalText;
  final LocaleManager localeManager;
  final TextEditingController necessaryTextcontroller;
  final TextEditingController optionalTextcontroller;
  final (int, int) myMaxLength;
  const AddWordField({
    super.key,
    required this.necessaryText,
    required this.optionalText,
    required this.localeManager,
    required this.necessaryTextcontroller,
    required this.optionalTextcontroller,
    required this.myMaxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            controller: necessaryTextcontroller,
            maxLength: myMaxLength.$1,
            decoration: InputDecoration(
              hintText: necessaryText,
              counterStyle: TextStyle(color: AppPalette.warningColor),
              hintStyle: TextStyle(color: AppPalette.whiteColor),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return localeManager.translate('AddWordErrorMessage');
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: optionalTextcontroller,
            maxLength: myMaxLength.$2,
            decoration: InputDecoration(
              hintText: optionalText,
              counterStyle: TextStyle(color: AppPalette.warningColor),
              hintStyle: TextStyle(color: AppPalette.whiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
