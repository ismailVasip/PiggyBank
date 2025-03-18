import 'package:flutter/material.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';

class AppTheme {
  static _border([Color color = AppPalette.cardBorderColor]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
          color: color,
          width: 3
      )
  );
  static final themeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    textTheme: AppTextTheme.loraTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPalette.backgroundColor,
      foregroundColor: AppPalette.whiteColor
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(17.0),
      enabledBorder: _border(),
      border: _border(),
      focusedBorder: _border(AppPalette.gradient2),
      focusedErrorBorder: _border(AppPalette.gradient2),
      errorBorder: _border(AppPalette.errorColor),
    )
  );
}
