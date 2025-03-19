import 'package:flutter/material.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';

class AppTextTheme {
  static TextTheme get loraTextTheme {
    return const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Lora', fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontFamily: 'Lora', fontSize: 28, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontFamily: 'Lora', fontSize: 24, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontFamily: 'Lora', fontSize: 20, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontFamily: 'Lora', fontSize: 18, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontFamily: 'Lora', fontSize: 16, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontFamily: 'Lora', fontSize: 16, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontFamily: 'Lora', fontSize: 14, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontFamily: 'Lora', fontSize: 12, fontWeight: FontWeight.normal),
    );
  }

  static TextStyle get appBarTitle {
    return const TextStyle(
      fontFamily: 'Lora',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppPalette.whiteColor
    );
  }
  static TextStyle get addWordButtonText {
    return const TextStyle(
      fontFamily: 'Lora',
      fontSize: 24,
      shadows: [Shadow(color: AppPalette.whiteColor,blurRadius: 4)],
      color: AppPalette.gradient2
    );
  }
  static TextStyle get learningProcessTitleText {
    return const TextStyle(
      fontFamily: 'Lora',
      fontSize: 27,
      color: AppPalette.whiteColor
    );
  }
}