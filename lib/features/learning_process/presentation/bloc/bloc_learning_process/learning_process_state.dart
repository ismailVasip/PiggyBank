part of 'learning_process_bloc.dart';

@immutable
sealed class LearningProcessState {}

final class LearningProcessInitial extends LearningProcessState {}

final class LearningProcessLoading extends LearningProcessState{}

final class LearningProcessFailure extends LearningProcessInitial{
  final String error;

  LearningProcessFailure({required this.error});

}

final class LearningProcessSuccess extends LearningProcessInitial{
  
}
