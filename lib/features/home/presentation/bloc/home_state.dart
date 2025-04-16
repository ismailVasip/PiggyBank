part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadInProgress extends HomeState{}

final class HomeCreateProcessLoadSuccess extends HomeState{}

final class HomeCreateProcessLoadFailure extends HomeState{
  final String error;

  HomeCreateProcessLoadFailure({required this.error});
}

final class HomeFetchProcessesLoadSuccess extends HomeState{
  final List<LearningProcess> learningProcesses;

  HomeFetchProcessesLoadSuccess({required this.learningProcesses});
}
final class HomeFetchProcessesLoadFailure extends HomeState{
  final String error;

  HomeFetchProcessesLoadFailure({required this.error});
}

final class HomeDeleteProcessLoadFailure extends HomeState{
  final String error;

  HomeDeleteProcessLoadFailure({required this.error});
}

final class HomeDeleteProcessLoadSuccess extends HomeState{}