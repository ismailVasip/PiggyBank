import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggy_bank/features/learning_process/domain/entities/word_pool.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/add_to_piggybank.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/fetch_all_words.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/fetch_summary.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/remove_word.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/upload_to_word_pool.dart';

part 'learning_process_event.dart';
part 'learning_process_state.dart';

class LearningProcessBloc
    extends Bloc<LearningProcessBlocEvent, LearningProcessState> {
  final UploadToWordPool _uploadToWordPool;
  final FetchSummary _fetchSummary;
  final FetchAllWords _fetchAllWords;
  final RemoveWord _removeWord;
  final AddToPiggyBank _addToPiggyBank;
  LearningProcessBloc({
    required UploadToWordPool uploadToWordPool,
    required FetchSummary fetchSummary,
    required FetchAllWords fetchAllWords,
    required RemoveWord removeWord,
    required AddToPiggyBank addToPiggyBank,
  }) : _uploadToWordPool = uploadToWordPool,
       _fetchSummary = fetchSummary,
       _fetchAllWords = fetchAllWords,
       _removeWord = removeWord,
       _addToPiggyBank = addToPiggyBank,
       super(LearningProcessInitial()) {
    on<LearningProcessWordAdded>(_learningProcessWordAdded);
    on<LoadLearningProcessSummary>(_loadSummary);
    on<LearningProcessFetchAllWords>(_learningProcessFetchAllWords);
    on<LearningProcessDeleteWord>(_learningProcessDeleteWord);
    on<LearningProcessAddToPiggyBank>(_learningProcessAddToPiggyBank);
  }

  void _learningProcessWordAdded(
    LearningProcessWordAdded event,
    Emitter<LearningProcessState> emit,
  ) async {
    //emit(LearningProcessLoading());
    final result = await _uploadToWordPool(
      UploadToWordPoolParams(
        word: event.word,
        meaning: event.meaning,
        type: event.type,
        synonym: event.synonym,
        sentence: event.sentence,
        learningProcessId: event.learningProcessId,
        isItLearned: event.isItLearned,
      ),
    );

    result.fold((l) => emit(AddedToWordPoolFailure(l.toString())), (r) {
      emit(AddedToWordPoolSuccess(r));
      add(
        LoadLearningProcessSummary(event.learningProcessId, event.isItLearned),
      );
    });
  }

  FutureOr<void> _loadSummary(
    LoadLearningProcessSummary event,
    Emitter<LearningProcessState> emit,
  ) async {
    //emit(LearningProcessLoading());
    final sumResult = await _fetchSummary(
      FetchSummaryParams(
        processId: event.processId,
        isItLearned: event.isItLearned,
      ),
    );

    sumResult.fold((l) => {
      if(!event.isItLearned){
        emit(WordPoolSummaryLoadedFailure(l.toString()))
      } else {
        emit(PiggyBankSummaryLoadedFailure(l.toString()))
      }
      
    }, (r) {
      if (!event.isItLearned) {
        emit(WordPoolSummaryLoadedSuccess(lastAddedWord: r.$1, wordCount: r.$2));
      } else {
        emit(PiggyBankSummaryLoadedSuccess(lastAddedWord: r.$1, wordCount: r.$2));
      }
    });
  }

  FutureOr<void> _learningProcessFetchAllWords(
    LearningProcessFetchAllWords event,
    Emitter<LearningProcessState> emit,
  ) async {
    emit(LearningProcessLoading());
    final list = await _fetchAllWords(
      FetchAllWordsParams(
        learningProcessId: event.processId,
        isItLearned: event.isItLearned,
      ),
    );

    list.fold(
      (l) => emit(FetchedAllWordsFailure(l.toString())),
      (r) => emit(FetchedAllWordsSuccess(list: r)),
    );
  }

  FutureOr<void> _learningProcessDeleteWord(
    LearningProcessDeleteWord event,
    Emitter<LearningProcessState> emit,
  ) async {
    //emit(LearningProcessLoading());
    final res = await _removeWord(RemoveWordParams(id: event.wordId));

    res.fold((l) => emit(DeletedWordFailure(l.toString())), (r) {
      emit(DeletedWordSuccess());
      add(
        LearningProcessFetchAllWords(
          processId: event.processId,
          isItLearned: event.isItLearned,
        ),
      );
      add(LoadLearningProcessSummary(event.processId, event.isItLearned));
    });
  }

  FutureOr<void> _learningProcessAddToPiggyBank(
    LearningProcessAddToPiggyBank event,
    Emitter<LearningProcessState> emit,
  ) async {
    //emit(LearningProcessLoading());

    final res = await _addToPiggyBank(AddToPiggyBankParams(id: event.wordId));

    res.fold((l) => emit(AddedToPiggyBankFailure(l.toString())), (r) {
      emit(AddedToPiggyBankSuccess());
      add(
        LearningProcessFetchAllWords(
          processId: event.processId,
          isItLearned: event.isItLearned,
        ),
      );
      add(LoadLearningProcessSummary(event.processId, true));
      add(LoadLearningProcessSummary(event.processId, false));
    });

    
  }
}
