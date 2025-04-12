import 'package:flutter/material.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';
import 'package:piggy_bank/core/utils/capitalize_title.dart';
import 'package:piggy_bank/features/learning_process/presentation/pages/learning_process_page.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.title, required this.id});
  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppPalette.backgroundColor,
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
              builder: (context) => LearningProcessPage(id: id, title: title),
            ),
          );
        },
      ),
    );
  }
}
