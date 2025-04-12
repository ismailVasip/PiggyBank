import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggy_bank/core/common/widgets/loader.dart';
import 'package:piggy_bank/core/error/status_message.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';
import 'package:piggy_bank/core/utils/capitalize_title.dart';
import 'package:piggy_bank/core/utils/show_snackbar.dart';
import 'package:piggy_bank/features/learning_process/presentation/bloc/learning_process_bloc.dart';
import 'package:piggy_bank/features/learning_process/presentation/widgets/info_box.dart';
import 'package:provider/provider.dart';

class LearningProcessPage extends StatefulWidget {
  final String id;
  final String title;

  const LearningProcessPage({super.key, required this.id, required this.title});

  @override
  State<LearningProcessPage> createState() => _LearningProcessPageState();
}

class _LearningProcessPageState extends State<LearningProcessPage> {
  final wordController = TextEditingController();
  final meaningController = TextEditingController();
  final typeController = TextEditingController();
  final synonymController = TextEditingController();
  final sentenceController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final piggyBankImagePath = 'assets/icons/piggy-bank.png';
  final wordPoolImagePath = 'assets/icons/brainstorm.png';

  @override
  void initState() {
    context.read<LearningProcessBloc>().add(
      LoadLearningProcessSummary(widget.id, false),
    );
    context.read<LearningProcessBloc>().add(
      LoadLearningProcessSummary(widget.id, true),
    );
    super.initState();
  }

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

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
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
          title: Text(
            capitalizeTitle(widget.title),
            style: AppTextTheme.appBarTitle,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<LearningProcessBloc, LearningProcessState>(
                        buildWhen:
                            (previous, current) =>
                                current is PiggyBankSummaryLoaded,
                        builder: (context, state) {
                          switch (state) {
                            case LearningProcessLoading():
                              return Expanded(
                                child: SizedBox(
                                  height: 150,
                                  child: const Loader(),
                                ),
                              );
                            case PiggyBankSummaryLoaded(
                              :final lastAddedWord,
                              :final wordCount,
                            ):
                              return Expanded(
                                child: InfoBox(
                                  header: localeManager.translate(
                                    'InfoBoxMyPiggyBankTitle',
                                  ),
                                  lastAddedWord: lastAddedWord ?? '',
                                  wordCount: wordCount.toString(),
                                  colorCode: '0',
                                  imagePath: piggyBankImagePath,
                                ),
                              );
                            default:
                              return StatusMessage(
                                message: localeManager.translate(
                                  'UnexpectedSituationText',
                                ),
                              );
                          }
                        },
                      ),
                      const SizedBox(width: 16),
                      BlocBuilder<LearningProcessBloc, LearningProcessState>(
                        buildWhen:
                            (previous, current) =>
                                current is WordPoolSummaryLoaded,
                        builder: (context, state) {
                          switch (state) {
                            case LearningProcessLoading():
                              return Expanded(
                                child: SizedBox(
                                  height: 150,
                                  child: const Loader(),
                                ),
                              );
                            case WordPoolSummaryLoaded(
                              :final lastAddedWord,
                              :final wordCount,
                            ):
                              return Expanded(
                                child: InfoBox(
                                  header: localeManager.translate(
                                    'InfoBoxWordPoolTitle',
                                  ),
                                  lastAddedWord: lastAddedWord ?? '',
                                  wordCount: wordCount.toString(),
                                  colorCode: '1',
                                  imagePath: wordPoolImagePath,
                                ),
                              );
                            default:
                              return StatusMessage(
                                message: localeManager.translate(
                                  'UnexpectedSituationText',
                                ),
                              );
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  BlocListener<LearningProcessBloc, LearningProcessState>(
                    listener: (context, state) {
                      if (state is LearningProcessFailure) {
                        showSnackBar(context, state.error);
                      } else if (state is LearningProcessSuccess) {
                        showSnackBar(
                          context,
                          localeManager.translate(
                            'SnackbarMessageAddedToWordPool',
                          ),
                        );
                      }
                    },
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<LearningProcessBloc>().add(
                                LearningProcessWordAdded(
                                  word: wordController.text.trim(),
                                  meaning: meaningController.text.trim(),
                                  type: typeController.text.trim(),
                                  synonym: synonymController.text.trim(),
                                  sentence: sentenceController.text.trim(),
                                  learningProcessId: widget.id,
                                  isItLearned: false,
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
                        TextFormField(
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
