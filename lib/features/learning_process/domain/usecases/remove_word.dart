import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/core/usecase/usecase.dart';
import 'package:piggy_bank/features/learning_process/domain/repositories/word_pool_repo.dart';

class RemoveWord implements UseCase<bool,RemoveWordParams>  {

  final WordPoolRepo _wordPoolRepo;

  RemoveWord(this._wordPoolRepo);

  @override
  Future<Either<Failure, bool>> call(RemoveWordParams params) async{
    return await _wordPoolRepo.removeWord(params.id);
  }
}

class RemoveWordParams{
  final String id;

  RemoveWordParams({required this.id});
}