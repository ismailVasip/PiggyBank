import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/features/learning_process/domain/entities/learning_process.dart';

abstract interface class LearningProcessRepo{
  Future<Either<Failure,LearningProcess>> createLearningProcess({
    required String title
  });
}