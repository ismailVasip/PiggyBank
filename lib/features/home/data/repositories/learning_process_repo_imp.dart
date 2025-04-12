import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/exceptions.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/features/home/data/datasources/create_learning_process_remote_date_source.dart';
import 'package:piggy_bank/features/home/data/models/learning_process_model.dart';
import 'package:piggy_bank/features/home/domain/entities/learning_process.dart';
import 'package:piggy_bank/features/home/domain/repositories/learning_process_repo.dart';
import 'package:uuid/uuid.dart';

class LearningProcessRepoImp implements LearningProcessRepo {
   final CreateLearningProcessRemoteDateSource learningProcessRemoteDataSource;
   LearningProcessRepoImp(this.learningProcessRemoteDataSource);

  @override
  Future<Either<Failure, LearningProcess>> createLearningProcess({
    required String title,
  }) async {
    try {
      LearningProcessModel learningProcessModel = LearningProcessModel(
        id: Uuid().v1(),
        title: title,
        updatedAt: DateTime.now(),
      );

      final model = await learningProcessRemoteDataSource.createLearningProcess(learningProcessModel);

      return right(model);
      
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, List<LearningProcess>>> getAllProcesses() async{
   try{
    final allProcesses = await learningProcessRemoteDataSource.getAllProcesses();

    return right(allProcesses);
    
   }on ServerException catch(e){
    return left(Failure(e.message));
   }
  }
}
