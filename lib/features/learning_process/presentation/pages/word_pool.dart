import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggy_bank/core/common/widgets/loader.dart';
import 'package:piggy_bank/core/error/status_message.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';
import 'package:piggy_bank/features/learning_process/presentation/bloc/learning_process_bloc.dart';
import 'package:piggy_bank/features/learning_process/presentation/widgets/listview_wordpool.dart';
import 'package:provider/provider.dart';

class WordPoolPage extends StatefulWidget {
  final String id;
  const WordPoolPage({super.key, required this.id});

  @override
  State<WordPoolPage> createState() => _WordPoolPageState();
}

class _WordPoolPageState extends State<WordPoolPage> {
  bool selected = false;
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 27,
            color: AppPalette.whiteColor,
          ),
        ),
        title: Text(
          localeManager.translate('InfoBoxWordPoolTitle'),
          style: AppTextTheme.appBarTitle,
        ),
      ),
      body: Container(
        color: AppPalette.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                style: TextStyle(color: AppPalette.primaryTextColor),
                decoration: InputDecoration(
                  hintText: localeManager.translate('SearchText'),
                  prefixIcon: Icon(Icons.search_sharp),
                  suffixIcon:
                      query.isNotEmpty
                          ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                              setState(() {
                                query = '';
                              });
                            },
                          )
                          : null,
                  filled: true,
                  fillColor: AppPalette.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
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
