import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/utils/capitalize_title.dart';
import 'package:piggy_bank/features/learning_process/domain/entities/word_pool.dart';

class CardFinalState extends StatelessWidget {
  final WordPool currentWord;
  const CardFinalState({super.key,required this.currentWord});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppPalette.whiteColor,
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: AutoSizeText(
                    maxLines: 2,
                    minFontSize: 13,
                    overflow: TextOverflow.ellipsis,
                    currentWord.type.isEmpty
                        ? '- ${capitalizeTitle(currentWord.word)}'
                        : '- ${capitalizeTitle(currentWord.word)} (${capitalizeTitle(currentWord.type)})',
                    style: TextStyle(
                      color: AppPalette.primaryTextColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: AutoSizeText(
                    maxLines: 2,
                    minFontSize: 13,
                    overflow: TextOverflow.ellipsis,
                    '- ${capitalizeTitle(currentWord.meaning)}',
                    style: TextStyle(
                      color: AppPalette.primaryTextColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                currentWord.synonym.isNotEmpty
                    ? Flexible(
                      flex: 1,
                      child: AutoSizeText(
                        maxLines: 2,
                        minFontSize: 13,
                        overflow: TextOverflow.ellipsis,
                        '- ${capitalizeTitle(currentWord.synonym)}',
                        style: TextStyle(
                          color: AppPalette.primaryTextColor,
                          fontSize: 17,
                        ),
                      ),
                    )
                    : SizedBox(),
                currentWord.sentence.isNotEmpty
                    ? Flexible(
                      flex: 2,
                      child: AutoSizeText(
                        minFontSize: 13,
                        '- ${capitalizeTitle(currentWord.sentence)}',
                        style: TextStyle(
                          color: AppPalette.primaryTextColor,
                          fontSize: 17,
                        ),
                      ),
                    )
                    : SizedBox(),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_up, size: 27),
        ],
      ),
    );
  }
}
