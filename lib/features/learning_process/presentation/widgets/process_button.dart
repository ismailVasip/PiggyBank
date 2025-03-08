import 'package:flutter/material.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';

class ProcessButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const ProcessButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text
        ,style: AppTextTheme.loraTextTheme.bodyMedium!.copyWith(
          color: AppPalette.blackColor
        ),
      ),
    );
  }
}
