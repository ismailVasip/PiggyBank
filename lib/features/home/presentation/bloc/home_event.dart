part of 'home_bloc.dart';

sealed class HomeEvent {}

final class HomeLearningProcessCreated extends HomeEvent{
  final String title;

  HomeLearningProcessCreated({required this.title});
}

final class HomeAllProcessesFetched extends HomeEvent{}

final class HomeProcessDeleted extends HomeEvent{
  final String id;

  HomeProcessDeleted({required this.id});
}
