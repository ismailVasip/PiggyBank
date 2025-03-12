import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';
import 'package:provider/provider.dart';

class LearningProcessPage extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => LearningProcessPage());

  const LearningProcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localeManager = Provider.of<LocaleManager>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 27,
              color: AppPalette.whiteColor,
            ),
          ),
          title: Text('Title', style: AppTextTheme.appBarTitle),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoBox(
                    header: localeManager.translate('InfoBoxMyPiggyBankTitle'),
                  ),
                  InfoBox(
                    header: localeManager.translate('InfoBoxWordPoolTitle'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AddToPoolButton(localeManager: localeManager),
              const SizedBox(height: 24),
              AddWordField(
                necessaryText: localeManager.translate(
                  'AddWordFieldNecessaryText1',
                ),
                optionalText: localeManager.translate(
                  'AddWordFieldOptionalText1',
                ),
              ),
              const SizedBox(height: 14),
              AddWordField(
                necessaryText: localeManager.translate(
                  'AddWordFieldNecessaryText2',
                ),
                optionalText: localeManager.translate(
                  'AddWordFieldOptionalText2',
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: TextFormField(
                  maxLength: 100,
                  minLines: 10,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: localeManager.translate('AddWordFieldAddSentences'),
                    hintStyle: TextStyle(color: AppPalette.whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddWordField extends StatelessWidget {
  final String necessaryText;
  final String optionalText;
  const AddWordField({
    super.key,
    required this.necessaryText,
    required this.optionalText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: necessaryText,
              hintStyle: TextStyle(color: AppPalette.whiteColor),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: optionalText,
              hintStyle: TextStyle(color: AppPalette.whiteColor),
            ),
          ),
        ),
      ],
    );
  }
}

class AddToPoolButton extends StatelessWidget {
  const AddToPoolButton({super.key, required this.localeManager});

  final LocaleManager localeManager;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_task, color: AppPalette.gradient2, size: 24),
        const SizedBox(width: 6),
        Text(
          localeManager.translate('AddTheWordButton'),
          style: AppTextTheme.addWordButtonText,
        ),
      ],
    );
  }
}

class InfoBox extends StatelessWidget {
  final String header;
  const InfoBox({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    final localeManager = Provider.of<LocaleManager>(context);
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 20,
      height: 150,
      decoration: BoxDecoration(
        color: AppPalette.gradient3,
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
                content: 'null',
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              flex: 1,
              child: ContentOfInfoBox(
                header: localeManager.translate('InfoBoxCountOfWordsText'),
                content: 'null',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
