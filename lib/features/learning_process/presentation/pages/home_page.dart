import "package:flutter/material.dart";
import "package:piggy_bank/core/localization/locale_manager.dart";
import "package:piggy_bank/core/theme/app_pallete.dart";
import "package:piggy_bank/core/theme/app_text_theme.dart";
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
              icon: Icon(Icons.settings, color: AppPalette.whiteColor, size: 27),
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
                showAlertDialog: (){
                  showAlertDialog(context,localeManager,fieldController);
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
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, LearningProcessPage.route());
                    },
                    child: Text("gittttttt"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showAlertDialog(
    BuildContext context,
    LocaleManager localeManager,
    TextEditingController fieldController,
  ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            localeManager.translate('addProcessTitle'),
            style: AppTextTheme.loraTextTheme.headlineSmall!.copyWith(
              color: AppPalette.primaryTextColor,
            ),
          ),
          content: ProcessField(
            hintText: localeManager.translate('addProcessFieldHintText'),
            controller: fieldController,
            isObscureText: false,
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
