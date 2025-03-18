import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggy_bank/core/common/widgets/loader.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';
import 'package:piggy_bank/core/utils/show_snackbar.dart';
import 'package:piggy_bank/features/learning_process/presentation/bloc/wordpool_bloc_bloc.dart';
import 'package:provider/provider.dart';

class LearningProcessPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => LearningProcessPage());

  const LearningProcessPage({super.key});

  @override
  State<LearningProcessPage> createState() => _LearningProcessPageState();
}

class _LearningProcessPageState extends State<LearningProcessPage> {
  final wordController = TextEditingController();
  final meaningController = TextEditingController();
  final typeController = TextEditingController();
  final synonymController = TextEditingController();
  final sentenceController = TextEditingController();

  @override
  void dispose() {
    wordController.dispose();
    meaningController.dispose();
    typeController.dispose();
    synonymController.dispose();
    sentenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localeManager = Provider.of<LocaleManager>(context);
    final formKey = GlobalKey<FormState>();

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
        body: BlocConsumer<WordpoolBlocBloc, WordpoolBlocState>(
          listener: (context, state) {
            if (state is WordpoolBlocFailure) {
              showSnackBar(context, state.error);
            } else if (state is WordpoolBlocSuccess) {
              showSnackBar(
                context,
                localeManager.translate('SnackbarMessageAddedToWordPool'),
              );
            }
          },
          builder: (context, state) {
            if(state is WordpoolBlocLoading){
              return const Loader();
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoBox(
                          header: localeManager.translate(
                            'InfoBoxMyPiggyBankTitle',
                          ),
                        ),
                        InfoBox(
                          header: localeManager.translate(
                            'InfoBoxWordPoolTitle',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<WordpoolBlocBloc>().add(
                            ToWordPoolUpload(
                              word: wordController.text.trim(),
                              meaning: meaningController.text.trim(),
                              type: typeController.text.trim(),
                              synonym: synonymController.text.trim(),
                              sentence: synonymController.text.trim(),
                            ),
                          );
                          formKey.currentState!.reset();
                        }
                      },
                      child: AddToPoolButton(localeManager: localeManager),
                    ),
                    const SizedBox(height: 24),
                    AddWordField(
                      necessaryText: localeManager.translate(
                        'AddWordFieldNecessaryText1',
                      ),
                      optionalText: localeManager.translate(
                        'AddWordFieldOptionalText1',
                      ),
                      localeManager: localeManager,
                      necessaryTextcontroller: wordController,
                      optionalTextcontroller: typeController,
                    ),
                    const SizedBox(height: 14),
                    AddWordField(
                      necessaryText: localeManager.translate(
                        'AddWordFieldNecessaryText2',
                      ),
                      optionalText: localeManager.translate(
                        'AddWordFieldOptionalText2',
                      ),
                      localeManager: localeManager,
                      necessaryTextcontroller: meaningController,
                      optionalTextcontroller: synonymController,
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: TextFormField(
                        controller: sentenceController,
                        maxLength: 100,
                        minLines: 10,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: localeManager.translate(
                            'AddWordFieldAddSentences',
                          ),
                          hintStyle: TextStyle(color: AppPalette.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AddWordField extends StatelessWidget {
  final String necessaryText;
  final String optionalText;
  final LocaleManager localeManager;
  final TextEditingController necessaryTextcontroller;
  final TextEditingController optionalTextcontroller;
  const AddWordField({
    super.key,
    required this.necessaryText,
    required this.optionalText,
    required this.localeManager,
    required this.necessaryTextcontroller,
    required this.optionalTextcontroller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            controller: necessaryTextcontroller,
            decoration: InputDecoration(
              hintText: necessaryText,
              hintStyle: TextStyle(color: AppPalette.whiteColor),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return localeManager.translate('AddWordErrorMessage');
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: optionalTextcontroller,
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
      spacing: 6,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.add_task, color: AppPalette.gradient2, size: 24),
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
