import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggy_bank/core/common/widgets/loader.dart';
import 'package:piggy_bank/core/error/status_message.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/features/learning_process/presentation/bloc/learning_process_bloc.dart';
import 'package:piggy_bank/features/learning_process/presentation/widgets/app_bar.dart';
import 'package:piggy_bank/features/learning_process/presentation/widgets/listview_wordpool.dart';
import 'package:piggy_bank/features/learning_process/presentation/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class WordPoolPage extends StatefulWidget {
  final String id;
  const WordPoolPage({super.key, required this.id});

  @override
  State<WordPoolPage> createState() => _WordPoolPageState();
}

class _WordPoolPageState extends State<WordPoolPage> {
  final searchController = TextEditingController();
  String query = '';

  @override
  void initState() {
    context.read<LearningProcessBloc>().add(
      LearningProcessFetchAllWords(processId: widget.id, isItLearned: false),
    );
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localeManager = Provider.of<LocaleManager>(context);

    return Scaffold(
      appBar: MyAppBar(title: localeManager.translate('InfoBoxWordPoolTitle')),
      body: Container(
        color: AppPalette.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MySearchBar(
                controller: searchController,
                query: query,
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                onClear: () {
                  searchController.clear();
                  setState(() {
                    query = '';
                  });
                },
                hintText: localeManager.translate('SearchText'),
              ),
              Expanded(
                child: BlocConsumer<LearningProcessBloc, LearningProcessState>(
                  listenWhen:
                      (previous, current) =>
                          current is DeletedWordSuccess ||
                          current is AddedToPiggyBankSuccess,
                  listener: (context, state) {
                    if (state is DeletedWordSuccess) {
                      Navigator.of(context).pop();
                    } else if (state is AddedToPiggyBankSuccess) {
                      Navigator.of(context).pop();
                    }
                  },
                  buildWhen:
                      (previous, current) => current is FetchedAllWordsSuccess,
                  builder: (context, state) {
                    switch (state) {
                      case LearningProcessLoading():
                        return Expanded(
                          child: SizedBox(height: 150, child: const Loader()),
                        );
                      case FetchedAllWordsSuccess(:final list):
                        final filteredWords =
                            list
                                .where(
                                  (wordModel) => wordModel.word
                                      .toLowerCase()
                                      .contains(query.toLowerCase()),
                                )
                                .toList();
                        return ListviewWordpool(filteredWords: filteredWords);
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
            ],
          ),
        ),
      ),
    );
  }
}
