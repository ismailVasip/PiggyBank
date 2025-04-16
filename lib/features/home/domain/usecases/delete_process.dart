import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/core/usecase/usecase.dart';
import 'package:piggy_bank/features/home/domain/repositories/learning_process_repo.dart';

class DeleteProcess implements UseCase<bool,DeleteProcessParams> {
   final LearningProcessRepo _learningProcessRepo;

  DeleteProcess(this._learningProcessRepo);
  @override
  Future<Either<Failure, bool>> call(DeleteProcessParams params)async {
    return await _learningProcessRepo.deleteProcess(params.processId);
  }
}

class DeleteProcessParams {
  final String processId;

  DeleteProcessParams({required this.processId});
}