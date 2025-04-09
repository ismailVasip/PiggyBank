part of 'home_bloc.dart';

sealed class HomeEvent {}

final class HomeLearningProcessCreated extends HomeEvent{
  final String title;

  HomeLearningProcessCreated({required this.title});
}

final class HomeAllProcessesFetched extends HomeEvent{}
