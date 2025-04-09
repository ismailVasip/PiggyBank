import 'package:flutter/material.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';

class StatusMessage extends StatelessWidget {
  const StatusMessage({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: AppPalette.whiteColor, fontSize: 17),
      ),
    );
  }
}
