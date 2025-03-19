import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/create_learning_process.dart';

part 'learning_process_event.dart';
part 'learning_process_state.dart';

class LearningProcessBloc
    extends Bloc<LearningProcessEvent, LearningProcessState> {
  final CreateLearningProcess createLearningProcess;
  LearningProcessBloc(this.createLearningProcess)
    : super(LearningProcessInitial()) {
    on<LearningProcessEvent>((event, emit) => emit(LearningProcessLoading()));
    on<LearningProcessCreate>(_learningProcessCreate);
  }
  void _learningProcessCreate(
    LearningProcessCreate event,
    Emitter<LearningProcessState> emit,
  ) async {
    final result = await createLearningProcess(
      CreateLearningProcessParams(title: event.title),
    );

    result.fold(
      (l) => emit(LearningProcessFailure(error: l.message)),
      (r) => emit(LearningProcessSuccess()),
    );
  }
}
