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
import 'package:piggy_bank/features/learning_process/presentation/pages/piggy_bank.dart';
import 'package:piggy_bank/features/learning_process/presentation/pages/word_pool.dart';
import 'package:piggy_bank/features/learning_process/presentation/widgets/add_to_pool_button.dart';
import 'package:piggy_bank/features/learning_process/presentation/widgets/add_word_field.dart';
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
                                current is PiggyBankSummaryLoadedSuccess ||
                                current is PiggyBankSummaryLoadedFailure ||
                                current is LearningProcessInitial,
                        builder: (context, state) {
                          switch (state) {
                            case LearningProcessInitial():
                              return Expanded(
                                child: Center(
                                  child: Loader(),
                                ),
                              );
                            case PiggyBankSummaryLoadedSuccess(
                              :final lastAddedWord,
                              :final wordCount,
                            ):
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (buildContext) =>
                                                PiggyBank(id: widget.id),
                                      ),
                                    );
                                  },
                                  child: InfoBox(
                                    header: localeManager.translate(
                                      'InfoBoxMyPiggyBankTitle',
                                    ),
                                    lastAddedWord: lastAddedWord ?? '',
                                    wordCount: wordCount.toString(),
                                    colorCode: '0',
                                    imagePath: piggyBankImagePath,
                                  ),
                                ),
                              );

                            case PiggyBankSummaryLoadedFailure(:final error):
                              return StatusMessage(message: error);
                            default:
                              return Expanded(
                                child: StatusMessage(
                                  message: localeManager.translate(
                                    'UnexpectedSituationText',
                                  ),
                                ),
                              );
                          }
                        },
                      ),
                      const SizedBox(width: 16),
                      BlocBuilder<LearningProcessBloc, LearningProcessState>(
                        buildWhen:
                            (previous, current) =>
                                current is WordPoolSummaryLoadedSuccess ||
                                current is WordPoolSummaryLoadedFailure ||
                                current is LearningProcessInitial,
                        builder: (context, state) {
                          switch (state) {
                            case LearningProcessInitial():
                              return Expanded(
                                child: Center(
                                  child: Loader(),
                                ),
                              );
                            case WordPoolSummaryLoadedSuccess(
                              :final lastAddedWord,
                              :final wordCount,
                            ):
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (buildContext) =>
                                                WordPoolPage(id: widget.id),
                                      ),
                                    );
                                  },
                                  child: InfoBox(
                                    header: localeManager.translate(
                                      'InfoBoxWordPoolTitle',
                                    ),
                                    lastAddedWord: lastAddedWord ?? '',
                                    wordCount: wordCount.toString(),
                                    colorCode: '1',
                                    imagePath: wordPoolImagePath,
                                  ),
                                ),
                              );
                            case WordPoolSummaryLoadedFailure(:final error):
                              return StatusMessage(message: error);

                            default:
                              return Expanded(
                                child: StatusMessage(
                                  message: localeManager.translate(
                                    'UnexpectedSituationText',
                                  ),
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
                      if (state is AddedToWordPoolFailure) {
                        showSnackBar(context, state.error);
                      } else if (state is AddedToWordPoolSuccess) {
                        showSnackBar(
                          context,
                          localeManager.translate(
                            'SnackbarMessageAddedToWordPool',
                          ),
                        );
                      }
                    },
                    child: Material(
                      color: AppPalette.secondaryBackgroundColor,
                      shadowColor: AppPalette.whiteColor,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                              child: AddToPoolButton(
                                localeManager: localeManager,
                              ),
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
                              myMaxLength: (45, 15),
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
                              myMaxLength: (45, 45),
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
                                counterStyle: TextStyle(
                                  color: AppPalette.warningColor,
                                ),
                                hintStyle: TextStyle(
                                  color: AppPalette.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
