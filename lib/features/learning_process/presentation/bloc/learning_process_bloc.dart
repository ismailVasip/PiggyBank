import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggy_bank/features/learning_process/domain/entities/word_pool.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/fetch_summary.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/upload_to_word_pool.dart';

part 'learning_process_event.dart';
part 'learning_process_state.dart';

class LearningProcessBloc
    extends Bloc<LearningProcessBlocEvent, LearningProcessState> {
  final UploadToWordPool _uploadToWordPool;
  final FetchSummary _fetchSummary;
  LearningProcessBloc({
    required UploadToWordPool uploadToWordPool,
    required FetchSummary fetchSummary,
  }) : _uploadToWordPool = uploadToWordPool,
       _fetchSummary = fetchSummary,
       super(LearningProcessInitial()) {
    on<LearningProcessWordAdded>(_learningProcessWordAdded);
    on<LoadLearningProcessSummary>(_loadWordPoolSummary);
  }

  void _learningProcessWordAdded(
    LearningProcessWordAdded event,
    Emitter<LearningProcessState> emit,
  ) async {
    emit(LearningProcessLoading());
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

    result.fold((l) => emit(LearningProcessFailure(l.message)), (r) {
      emit(LearningProcessSuccess(r));
      add(
        LoadLearningProcessSummary(event.learningProcessId, event.isItLearned),
      );
    });
  }

  FutureOr<void> _loadWordPoolSummary(
    LoadLearningProcessSummary event,
    Emitter<LearningProcessState> emit,
  ) async {
    emit(LearningProcessLoading());
    final sumResult = await _fetchSummary(
      FetchSummaryParams(
        processId: event.processId,
        isItLearned: event.isItLearned,
      ),
    );

    sumResult.fold((l) => emit(LearningProcessFailure(l.message)), (r) {
      if (!event.isItLearned) {
        emit(WordPoolSummaryLoaded(lastAddedWord: r.$1, wordCount: r.$2));
      }else{
        emit(PiggyBankSummaryLoaded(lastAddedWord: r.$1,wordCount: r.$2));
      }
    });
  }
}
