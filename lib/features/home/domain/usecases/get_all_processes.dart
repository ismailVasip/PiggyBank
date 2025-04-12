import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/core/usecase/usecase.dart';
import 'package:piggy_bank/features/home/domain/entities/learning_process.dart';
import 'package:piggy_bank/features/home/domain/repositories/learning_process_repo.dart';

class GetAllProcesses implements UseCase<List<LearningProcess>,NoParams>{
  final LearningProcessRepo _repo;
  GetAllProcesses(this._repo);
  @override
  Future<Either<Failure, List<LearningProcess>>> call(NoParams params) async{
    return await _repo.getAllProcesses();
  }
}