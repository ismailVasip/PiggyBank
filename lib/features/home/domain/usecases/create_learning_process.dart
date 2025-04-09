import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/core/usecase/usecase.dart';
import 'package:piggy_bank/features/home/domain/entities/learning_process.dart';
import 'package:piggy_bank/features/home/data/repositories/learning_process_repo.dart';

class CreateLearningProcess implements UseCase<LearningProcess,CreateLearningProcessParams>{
  final LearningProcessRepo _learningProcessRepo;
  CreateLearningProcess(this._learningProcessRepo);

  @override
  Future<Either<Failure, LearningProcess>> call(CreateLearningProcessParams params) async{
       return await _learningProcessRepo.createLearningProcess(title: params.title);
  }
}

class CreateLearningProcessParams{
  final String title;

  CreateLearningProcessParams({required this.title});
  
}