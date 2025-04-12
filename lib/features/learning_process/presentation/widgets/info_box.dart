import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';
import 'package:piggy_bank/features/learning_process/presentation/widgets/content_of_infobox.dart';
import 'package:provider/provider.dart';

class InfoBox extends StatelessWidget {
  final String header;
  final String lastAddedWord;
  final String wordCount;
  final String colorCode;
  final String imagePath;
  const InfoBox({
    super.key,
    required this.header,
    required this.lastAddedWord,
    required this.wordCount,
    required this.colorCode,
    required this.imagePath
  });

  @override
  Widget build(BuildContext context) {
    final localeManager = Provider.of<LocaleManager>(context);
    return SizedBox(
      height: 170,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color:
                  colorCode == '0' ? AppPalette.gradient11 : AppPalette.gradient8,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [BoxShadow(color: AppPalette.whiteColor, blurRadius: 4)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: AutoSizeText(
                      header,
                      style: AppTextTheme.loraTextTheme.displayMedium,
                      maxLines: 1,
                      minFontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    flex: 1,
                    child: ContentOfInfoBox(
                      header: localeManager.translate('InfoBoxLastAddedText'),
                      content: lastAddedWord,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    flex: 1,
                    child: ContentOfInfoBox(
                      header: localeManager.translate('InfoBoxCountOfWordsText'),
                      content: wordCount,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top:-20,
            right:0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
