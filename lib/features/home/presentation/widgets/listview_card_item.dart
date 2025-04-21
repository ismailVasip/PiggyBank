import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';
import 'package:piggy_bank/core/utils/capitalize_title.dart';
import 'package:piggy_bank/features/home/presentation/bloc/home_bloc.dart';
import 'package:piggy_bank/features/home/presentation/widgets/process_button.dart';
import 'package:piggy_bank/features/learning_process/presentation/pages/learning_process_page.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.title, required this.id});
  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    final localeManager = Provider.of<LocaleManager>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Slidable(
        key: ValueKey(id),
        groupTag: 'processes',
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(16.0),
              onPressed: (_) {
                deleteWordDialog(context, localeManager, id);
              },
              backgroundColor: AppPalette.errorColor,
              foregroundColor: AppPalette.whiteColor,
              icon: Icons.delete,
            ),
          ],
        ),
        child: SizedBox(
          height: 60,
          child: Card(
            color: AppPalette.backgroundColor,
            margin: EdgeInsets.zero, // Kartın dış boşluklarını kaldır
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ListTile(
              leading: Icon(
                Icons.library_books,
                size: 27,
                color: AppPalette.gradient9,
              ),
              title: Text(
                capitalizeTitle(title),
                style: AppTextTheme.learningProcessTitleText,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 21,
                color: AppPalette.whiteColor,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => LearningProcessPage(id: id, title: title),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> deleteWordDialog(
  BuildContext context,
  LocaleManager localeManager,
  String id,
) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (alertDialogContext) {
      return AlertDialog(
        title: Text(
          localeManager.translate('DeleteProcess'),
          style: AppTextTheme.loraTextTheme.headlineSmall!.copyWith(
            color: AppPalette.primaryTextColor,
          ),
        ),

        actions: [
          ProcessButton(
            text: localeManager.translate(localeManager.translate('No')),
            onPressed: () {
              Navigator.of(alertDialogContext).pop();
            },
          ),
          ProcessButton(
            text: localeManager.translate(localeManager.translate('Yes')),
            onPressed: () {
              context.read<HomeBloc>().add(HomeProcessDeleted(id: id));
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
