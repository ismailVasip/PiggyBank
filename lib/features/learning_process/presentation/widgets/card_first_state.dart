import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/utils/capitalize_title.dart';
import 'package:piggy_bank/features/learning_process/domain/entities/word_pool.dart';

class CardFirstState extends StatelessWidget {
  final WordPool currentWord;
  const CardFirstState({super.key,required this.currentWord});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppPalette.whiteColor,
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.keyboard_arrow_down, size: 27),
          Expanded(
            child: AutoSizeText(
              maxLines: 2,
              minFontSize: 14,
              overflow: TextOverflow.ellipsis,
              capitalizeTitle(currentWord.word),
              style: TextStyle(
                color: AppPalette.primaryTextColor,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
