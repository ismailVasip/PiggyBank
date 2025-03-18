part of 'wordpool_bloc_bloc.dart';

@immutable
sealed class WordpoolBlocEvent {}

final class ToWordPoolUpload extends WordpoolBlocEvent {
  final String word;
  final String meaning;
  final String type;
  final String synonym;
  final String sentence;

  ToWordPoolUpload({
    required this.word,
    required this.meaning,
    required this.type,
    required this.synonym,
    required this.sentence,
  });
}
