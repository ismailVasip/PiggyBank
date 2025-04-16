part of 'learning_process_bloc.dart';

sealed class LearningProcessBlocEvent {}

final class LearningProcessWordAdded extends LearningProcessBlocEvent {

  final String word;
  final String meaning;
  final String type;
  final String synonym;
  final String sentence;
  final String learningProcessId;
  final bool isItLearned;

  LearningProcessWordAdded({
    required this.word,
    required this.meaning,
    required this.type,
    required this.synonym,
    required this.sentence,
    required this.learningProcessId,
    required this.isItLearned
  });
}

final class LoadLearningProcessSummary extends LearningProcessBlocEvent {
  final String processId;
  final bool isItLearned;
  LoadLearningProcessSummary(this.processId,this.isItLearned);
}

final class LearningProcessFetchAllWords extends LearningProcessBlocEvent{
  final String processId;
  final bool isItLearned;

  LearningProcessFetchAllWords({required this.processId, required this.isItLearned});
}

final class LearningProcessDeleteWord extends LearningProcessBlocEvent {
  final String wordId;
  final String processId;
  final bool isItLearned;

  LearningProcessDeleteWord({required this.wordId,required this.processId, required this.isItLearned});
  
}

final class LearningProcessAddToPiggyBank extends LearningProcessBlocEvent{
  final String wordId;
  final String processId;
  final bool isItLearned;

  LearningProcessAddToPiggyBank({required this.wordId, required this.processId, required this.isItLearned}); 
}