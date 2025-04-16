part of 'learning_process_bloc.dart';

sealed class LearningProcessState {}

final class LearningProcessInitial extends LearningProcessState {}

final class LearningProcessLoading extends LearningProcessState{}

final class LearningProcessFailure extends LearningProcessState{
  final String error;
  LearningProcessFailure(this.error);
}

final class LearningProcessSuccess extends LearningProcessState{
  final WordPool wordModel;

  LearningProcessSuccess(this.wordModel);
}
final class WordPoolSummaryLoaded extends LearningProcessState {
  final String? lastAddedWord;
  final int wordCount;
  WordPoolSummaryLoaded({
    required this.lastAddedWord,
    required this.wordCount,
  });
}
final class PiggyBankSummaryLoaded extends LearningProcessState {
  final String? lastAddedWord;
  final int wordCount;
  PiggyBankSummaryLoaded({
    required this.lastAddedWord,
    required this.wordCount,
  });
}

final class FetchedAllWordsSuccess extends LearningProcessState{
  final List<WordPool> list;

  FetchedAllWordsSuccess({required this.list});
}

final class DeletedWordSuccess extends LearningProcessState{}

final class AddedToPiggyBankSuccess extends LearningProcessState{}