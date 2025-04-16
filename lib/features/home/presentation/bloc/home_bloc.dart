import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piggy_bank/core/usecase/usecase.dart';
import 'package:piggy_bank/features/home/domain/entities/learning_process.dart';
import 'package:piggy_bank/features/home/domain/usecases/create_learning_process.dart';
import 'package:piggy_bank/features/home/domain/usecases/delete_process.dart';
import 'package:piggy_bank/features/home/domain/usecases/get_all_processes.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CreateLearningProcess _createLearningProcess;
  final GetAllProcesses _getAllProcesses;
  final DeleteProcess _deleteProcess;
  HomeBloc({
    required CreateLearningProcess createLearningProcess,
    required GetAllProcesses getAllProcesses,
    required DeleteProcess deleteProcess
  }) : _createLearningProcess = createLearningProcess,
       _getAllProcesses = getAllProcesses,
       _deleteProcess = deleteProcess,
       super(HomeInitial()) {
    on<HomeLearningProcessCreated>(_homeLearningProcessCreateEvent);
    on<HomeAllProcessesFetched>(_homeFetchAllProcessesEvent);
    on<HomeProcessDeleted>(_homeProcessDeleted);
  }

  FutureOr<void> _homeLearningProcessCreateEvent(
    HomeLearningProcessCreated event,
    Emitter<HomeState> emit,
  ) async {
    //emit(HomeLoadInProgress());
    final result = await _createLearningProcess(
      CreateLearningProcessParams(title: event.title),
    );
    result.fold((l) => emit(HomeCreateProcessLoadFailure(error: l.message)), (
      r,
    ) {
      emit(HomeCreateProcessLoadSuccess());
      add(HomeAllProcessesFetched());
    });
  }

  FutureOr<void> _homeFetchAllProcessesEvent(
    HomeAllProcessesFetched event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadInProgress());
    final result = await _getAllProcesses(NoParams());
    result.fold(
      (l) => emit(HomeFetchProcessesLoadFailure(error: l.message)),
      (r) => emit(HomeFetchProcessesLoadSuccess(learningProcesses: r)),
    );
  }

  FutureOr<void> _homeProcessDeleted(HomeProcessDeleted event, Emitter<HomeState> emit) async{
    //emit(HomeLoadInProgress());

    final result = await _deleteProcess(DeleteProcessParams(processId: event.id));

    result.fold(
      (l) => emit(HomeDeleteProcessLoadFailure(error: l.message)),
      (r){
        emit(HomeDeleteProcessLoadSuccess());
        add(HomeAllProcessesFetched());
      }
    );

  }
}
