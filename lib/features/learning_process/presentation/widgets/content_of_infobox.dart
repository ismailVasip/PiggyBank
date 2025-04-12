import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';

class ContentOfInfoBox extends StatelessWidget {
  final String header;
  final String content;
  const ContentOfInfoBox({
    super.key,
    required this.header,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AutoSizeText(
          header,
          style: AppTextTheme.loraTextTheme.bodyLarge,
          maxLines: 1,
          minFontSize: 10,
          overflow: TextOverflow.ellipsis,
        ),
        Expanded(
          child: AutoSizeText(
            content,
            style: AppTextTheme.loraTextTheme.bodyMedium,
            maxLines: 1,
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}