import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:piggy_bank/core/common/widgets/loader.dart";
import "package:piggy_bank/core/localization/locale_manager.dart";
import "package:piggy_bank/core/theme/app_pallete.dart";
import "package:piggy_bank/core/theme/app_text_theme.dart";
import "package:piggy_bank/core/utils/show_snackbar.dart";
import "package:piggy_bank/features/learning_process/presentation/bloc/bloc_learning_process/learning_process_bloc.dart";
import "package:piggy_bank/features/learning_process/presentation/pages/learning_process_page.dart";
import "package:piggy_bank/features/learning_process/presentation/pages/settings.dart";
import "package:piggy_bank/features/learning_process/presentation/widgets/process_button.dart";
import "package:piggy_bank/features/learning_process/presentation/widgets/process_field.dart";
import "package:piggy_bank/features/learning_process/presentation/widgets/start_button.dart";
import "package:provider/provider.dart";

class HomePage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => HomePage());
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localeManager = Provider.of<LocaleManager>(context);
    final fieldController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
        body: Container(
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
              Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppPalette.secondaryBackgroundColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: ListView.separated(
                      itemCount: 12,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: AppPalette.whiteColor,
                          indent: 16,
                          endIndent: 16,
                        );
                      },
                      itemBuilder: (context, index) {
                        return generateListTile();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile generateListTile() {
    return ListTile(
      leading: Icon(
        Icons.library_books,
        size: 27,
        color: AppPalette.whiteColor,
      ),
      title: Text('Başlık', style: AppTextTheme.learningProcessTitleText),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 27,
        color: AppPalette.whiteColor,
      ),
    );
  }

  Future<dynamic> showAlertDialog(
    BuildContext context,
    LocaleManager localeManager,
    TextEditingController fieldController,
    GlobalKey<FormState> key,
  ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return BlocConsumer<LearningProcessBloc, LearningProcessState>(
          listener: (context, state) {
            if (state is LearningProcessFailure) {
              showSnackBar(context, state.error);
            } else if (state is LearningProcessSuccess) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is LearningProcessLoading) {
              return const Loader();
            }
            return Form(
              key: key,
              child: AlertDialog(
                title: Text(
                  localeManager.translate('addProcessTitle'),
                  style: AppTextTheme.loraTextTheme.headlineSmall!.copyWith(
                    color: AppPalette.primaryTextColor,
                  ),
                ),
                content: TextFormField(
                  style: TextStyle(color: AppPalette.blackColor),
                  decoration: InputDecoration(
                    hintText: localeManager.translate(
                      'addProcessFieldHintText',
                    ),
                  ),
                  controller: fieldController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return localeManager.translate('AddWordErrorMessage');
                    }
                    return null;
                  },
                ),
                actions: [
                  ProcessButton(
                    text: localeManager.translate('close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ProcessButton(
                    text: localeManager.translate('save'),
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        context.read<LearningProcessBloc>().add(
                          LearningProcessCreate(
                            title: fieldController.text.trim(),
                          ),
                        );
                      }
                      //key.currentState!.reset();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
