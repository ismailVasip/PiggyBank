part of 'wordpool_bloc_bloc.dart';

@immutable
sealed class WordpoolBlocState {}

final class WordpoolBlocInitial extends WordpoolBlocState {}

final class WordpoolBlocLoading extends WordpoolBlocState{}

final class WordpoolBlocFailure extends WordpoolBlocState{
  final String error;
  WordpoolBlocFailure(this.error);
}

final class WordpoolBlocSuccess extends WordpoolBlocState{}