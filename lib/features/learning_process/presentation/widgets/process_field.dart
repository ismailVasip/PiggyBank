import 'package:flutter/material.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';
import 'package:provider/provider.dart';

class ProcessField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  const ProcessField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.isObscureText,
  });

  @override
  Widget build(BuildContext context) {
    final localeManager = Provider.of<LocaleManager>(context);
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      style: AppTextTheme.loraTextTheme.bodyMedium!.copyWith(
        color: AppPalette.primaryTextColor,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText ${localeManager.translate('missing')}!";
        }
        return null;
      },
      obscureText: isObscureText,
    );
  }
}
