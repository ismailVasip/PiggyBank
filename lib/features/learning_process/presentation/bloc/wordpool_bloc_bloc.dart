import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/upload_to_word_pool.dart';

part 'wordpool_bloc_event.dart';
part 'wordpool_bloc_state.dart';

class WordpoolBlocBloc extends Bloc<WordpoolBlocEvent, WordpoolBlocState> {
  final UploadToWordPool uploadToWordPool;
  WordpoolBlocBloc(this.uploadToWordPool) : super(WordpoolBlocInitial()) {
    on<WordpoolBlocEvent>((event, emit) => emit(WordpoolBlocLoading()));
    on<ToWordPoolUpload>(_toWordPoolUpload);
  }

  void _toWordPoolUpload(
    ToWordPoolUpload event,
    Emitter<WordpoolBlocState> emit,
  ) async {
    final result = await uploadToWordPool(
      UploadToWordPoolParams(
        word: event.word,
        meaning: event.meaning,
        type: event.type,
        synonym: event.synonym,
        sentence: event.sentence,
      ),
    );

    result.fold(
      (l) => emit(WordpoolBlocFailure(l.message)),
      (r) => emit(WordpoolBlocSuccess()),
    );
  }
}
