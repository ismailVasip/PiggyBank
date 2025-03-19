import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/core/usecase/usecase.dart';
import 'package:piggy_bank/features/learning_process/domain/entities/learning_process.dart';
import 'package:piggy_bank/features/learning_process/domain/repositories/learning_process_repo.dart';

class CreateLearningProcess implements UseCase<LearningProcess,CreateLearningProcessParams>{
  final LearningProcessRepo learningProcessRepo;
  CreateLearningProcess(this.learningProcessRepo);

  @override
  Future<Either<Failure, LearningProcess>> call(CreateLearningProcessParams params) async{
       return await learningProcessRepo.createLearningProcess(title: params.title);
  }
}

class CreateLearningProcessParams{
  final String title;

  CreateLearningProcessParams({required this.title});
  
}