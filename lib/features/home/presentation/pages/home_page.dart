import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:piggy_bank/core/common/widgets/loader.dart";
import "package:piggy_bank/core/error/status_message.dart";
import "package:piggy_bank/core/localization/locale_manager.dart";
import "package:piggy_bank/core/theme/app_pallete.dart";
import "package:piggy_bank/core/theme/app_text_theme.dart";
import "package:piggy_bank/core/utils/show_snackbar.dart";
import "package:piggy_bank/features/home/presentation/bloc/home_bloc.dart";
import "package:piggy_bank/features/home/presentation/widgets/listview_card_item.dart";
import "package:piggy_bank/features/home/presentation/widgets/process_button.dart";
import "package:piggy_bank/features/home/presentation/widgets/start_button.dart";
import "package:piggy_bank/features/settings/presentation/pages/settings.dart";
import "package:provider/provider.dart";

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => HomePage());
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController fieldController;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<HomeBloc>().add(HomeAllProcessesFetched());
    super.initState();
    fieldController = TextEditingController();
  }

  @override
  void dispose() {
    fieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localeManager = Provider.of<LocaleManager>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            localeManager.translate('title'),
            style: AppTextTheme.appBarTitle,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, Settings.route());
              },
              icon: Icon(
                Icons.settings,
                color: AppPalette.whiteColor,
                size: 27,
              ),
            ),
          ],
        ),
        body: BlocListener<HomeBloc, HomeState>(
          listenWhen:
              (previous, current) =>
                  current is HomeCreateProcessLoadSuccess ||
                  current is HomeCreateProcessLoadFailure,
          listener: (context, state) {
            if (state is HomeCreateProcessLoadSuccess) {
              Navigator.of(context).pop();
            } else if (state is HomeCreateProcessLoadFailure) {
              showSnackBar(context, state.error);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StartButton(
                  text: localeManager.translate('start'),
                  showAlertDialog: () {
                    showAlertDialog(
                      context,
                      localeManager,
                      fieldController,
                      formKey,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  localeManager.translate('headline'),
                  style: AppTextTheme.loraTextTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppPalette.cardBorderColor,
                        width: 0.5,
                      ),
                      color: AppPalette.secondaryBackgroundColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            switch (state) {
                              case HomeInitial():
                                return StatusMessage(
                                  message: localeManager.translate(
                                    'DataLoadingText',
                                  ),
                                );

                              case HomeLoadInProgress():
                                return const Loader();

                              case HomeFetchProcessesLoadSuccess(
                                :final learningProcesses,
                              ):
                                return learningProcesses.isEmpty
                                    ? StatusMessage(
                                      message: localeManager.translate(
                                        'EmptyLearningProcessListText',
                                      ),
                                    )
                                    : ListView.builder(
                                      itemCount: learningProcesses.length,
                                      itemBuilder: (context, index) {
                                        return ListItem(
                                          title: learningProcesses[index].title,
                                          id: learningProcesses[index].id,
                                        );
                                      },
                                    );

                              case HomeFetchProcessesLoadFailure(:final error):
                                return StatusMessage(message: error);

                              default:
                                return StatusMessage(
                                  message: localeManager.translate(
                                    'UnexpectedSituationText',
                                  ),
                                );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showAlertDialog(
    BuildContext context,
    LocaleManager localeManager,
    TextEditingController fieldController,
    GlobalKey<FormState> key,
  ) {
    fieldController.clear();
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (alertDialogContext) {
        return AlertDialog(
          title: Text(
            localeManager.translate('addProcessTitle'),
            style: AppTextTheme.loraTextTheme.headlineSmall!.copyWith(
              color: AppPalette.primaryTextColor,
            ),
          ),
          content: Form(
            key: key,
            child: TextFormField(
              style: TextStyle(color: AppPalette.blackColor),
              decoration: InputDecoration(
                hintText: localeManager.translate('addProcessFieldHintText'),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: AppPalette.blackColor,
                    width: 2,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: AppPalette.errorColor,
                    width: 2,
                  ),
                ),
              ),
              controller: fieldController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return localeManager.translate('AddWordErrorMessage');
                }
                return null;
              },
            ),
          ),
          actions: [
            ProcessButton(
              text: localeManager.translate('close'),
              onPressed: () {
                Navigator.of(alertDialogContext).pop();
              },
            ),
            ProcessButton(
              text: localeManager.translate('save'),
              onPressed: () {
                if (key.currentState!.validate()) {
                  context.read<HomeBloc>().add(
                    HomeLearningProcessCreated(
                      title: fieldController.text.trim(),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
