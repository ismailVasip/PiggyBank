part of 'learning_process_bloc.dart';

sealed class LearningProcessState {}

final class LearningProcessInitial extends LearningProcessState {}

final class LearningProcessLoading extends LearningProcessState{}

final class AddedToWordPoolFailure extends LearningProcessState{
  final String error;
  AddedToWordPoolFailure(this.error);
}
final class AddedToWordPoolSuccess extends LearningProcessState{
  final WordPool wordModel;

  AddedToWordPoolSuccess(this.wordModel);
}

final class WordPoolSummaryLoadedSuccess extends LearningProcessState {
  final String? lastAddedWord;
  final int wordCount;
  WordPoolSummaryLoadedSuccess({
    required this.lastAddedWord,
    required this.wordCount,
  });
}
final class WordPoolSummaryLoadedFailure extends LearningProcessState{
  final String error;

  WordPoolSummaryLoadedFailure(this.error);
}

final class PiggyBankSummaryLoadedSuccess extends LearningProcessState {
  final String? lastAddedWord;
  final int wordCount;
  PiggyBankSummaryLoadedSuccess({
    required this.lastAddedWord,
    required this.wordCount,
  });
}
final class PiggyBankSummaryLoadedFailure extends LearningProcessState{
  final String error;
  PiggyBankSummaryLoadedFailure(this.error);
}

final class FetchedAllWordsSuccess extends LearningProcessState{
  final List<WordPool> list;

  FetchedAllWordsSuccess({required this.list});
}
final class FetchedAllWordsFailure extends LearningProcessState{
  final String error;
  FetchedAllWordsFailure(this.error);
}

final class DeletedWordSuccess extends LearningProcessState{}
final class DeletedWordFailure extends LearningProcessState{
  final String error;
  DeletedWordFailure(this.error);
}

final class AddedToPiggyBankSuccess extends LearningProcessState{}
final class AddedToPiggyBankFailure extends LearningProcessState{
  final String error;
  AddedToPiggyBankFailure(this.error);
}