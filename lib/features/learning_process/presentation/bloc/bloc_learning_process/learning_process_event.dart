part of 'learning_process_bloc.dart';

@immutable
sealed class LearningProcessEvent {}

final class LearningProcessCreate extends LearningProcessEvent{
  final String title;

  LearningProcessCreate({required this.title});

}
