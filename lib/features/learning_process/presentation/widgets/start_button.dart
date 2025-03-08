import 'package:flutter/material.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';

class StartButton extends StatelessWidget {
  final Function() showAlertDialog;
  final String text;
  const StartButton({super.key,required this.text,required this.showAlertDialog});

  @override
  Widget build(BuildContext context) {
    return Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppPalette.gradient1, AppPalette.gradient2],
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(120, 55),
                    backgroundColor:
                        AppPalette.transparentColor, //for show gradient
                    shadowColor:
                        AppPalette.transparentColor, //for exactly show gradient
                  ),
                  onPressed:showAlertDialog,
                  child: Text(
                    text,
                    style: AppTextTheme.loraTextTheme.headlineMedium!.copyWith(color: AppPalette.backgroundColor),
                  ),
                ),
              ),
            );
  }
}