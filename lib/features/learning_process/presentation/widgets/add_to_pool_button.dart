import 'package:flutter/material.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';

class AddToPoolButton extends StatelessWidget {
  const AddToPoolButton({super.key, required this.localeManager});
  final LocaleManager localeManager;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 6,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.done_outline, color: AppPalette.yellow, size: 24),
        Text(
          localeManager.translate('AddTheWordButton'),
          style: AppTextTheme.addWordButtonText,
        ),
      ],
    );
  }
}