import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';
import 'package:piggy_bank/features/home/presentation/widgets/process_button.dart';
import 'package:piggy_bank/features/learning_process/domain/entities/word_pool.dart';
import 'package:piggy_bank/features/learning_process/presentation/bloc/learning_process_bloc.dart';
import 'package:piggy_bank/features/learning_process/presentation/widgets/animated_container.dart';
import 'package:provider/provider.dart';

class ListviewPiggybank extends StatefulWidget {
  final List<WordPool> filteredWords;
  const ListviewPiggybank({super.key, required this.filteredWords});

  @override
  State<ListviewPiggybank> createState() => _ListviewPiggybankState();
}

class _ListviewPiggybankState extends State<ListviewPiggybank> {
  Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    final localeManager = Provider.of<LocaleManager>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
      child:
          widget.filteredWords.isEmpty
              ? Center(
                child: Text(
                  localeManager.translate('NoWordAddedYetText'),
                  style: TextStyle(color: AppPalette.whiteColor, fontSize: 17),
                ),
              )
              : ListView.separated(
                itemCount: widget.filteredWords.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final currentWord = widget.filteredWords[index];
                  final isSelected = selectedIndexes.contains(index);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedIndexes.remove(index);
                        } else {
                          selectedIndexes.add(index);
                        }
                      });
                    },
                    child: Slidable(
                      key: ValueKey(index),
                      closeOnScroll: true,
                      groupTag: "myWords",
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        extentRatio: 0.25,
                        children: [
                          SlidableAction(
                            borderRadius: BorderRadius.circular(16.0),
                            onPressed: (_) {
                              deleteWordDialog(
                                context,
                                localeManager,
                                currentWord,
                              );
                            },
                            backgroundColor: AppPalette.gradient10,
                            foregroundColor: AppPalette.whiteColor,
                            icon: Icons.delete,
                          ),
                        ],
                      ),
                      child: MyAnimatedContainer(
                        isSelected: isSelected,
                        currentWord: currentWord,
                      ),
                    ),
                  );
                },
              ),
    );
  }
}


 Future<dynamic> deleteWordDialog(
    BuildContext context,
    LocaleManager localeManager,
    WordPool currentWord,
  ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (alertDialogContext) {
        return AlertDialog(
          title: Text(
            localeManager.translate('DeleteTheWord'),
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
                context.read<LearningProcessBloc>().add(
                  LearningProcessDeleteWord(
                    wordId: currentWord.id,
                    processId: currentWord.learningProccessId,
                    isItLearned: currentWord.isItLearned,
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
