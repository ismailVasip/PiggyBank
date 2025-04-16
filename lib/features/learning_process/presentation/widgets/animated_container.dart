import 'package:flutter/material.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/features/learning_process/domain/entities/word_pool.dart';
import 'package:piggy_bank/features/learning_process/presentation/widgets/card_final_state.dart';
import 'package:piggy_bank/features/learning_process/presentation/widgets/card_first_state.dart';

class MyAnimatedContainer extends StatelessWidget {
  final bool isSelected;
  final WordPool currentWord;
  const MyAnimatedContainer({super.key,required this.isSelected, required this.currentWord});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 500),
      curve: Curves.fastOutSlowIn,
      width: double.infinity,
      height: !isSelected ? 60 : 150,
      decoration: BoxDecoration(
        color: AppPalette.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child:
          !isSelected
              ? CardFirstState(currentWord:currentWord)
              : CardFinalState(currentWord: currentWord,)
    );
  }
}
