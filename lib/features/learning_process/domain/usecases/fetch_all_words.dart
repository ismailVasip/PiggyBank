import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/core/usecase/usecase.dart';
import 'package:piggy_bank/features/learning_process/domain/entities/word_pool.dart';
import 'package:piggy_bank/features/learning_process/domain/repositories/word_pool_repo.dart';

class FetchAllWords implements UseCase<List<WordPool>,FetchAllWordsParams>{
  final WordPoolRepo _wordPoolRepo;

  FetchAllWords(this._wordPoolRepo);
  
  @override
  Future<Either<Failure, List<WordPool>>> call(FetchAllWordsParams params) async{
    return await _wordPoolRepo.fetchAllWords(params.learningProcessId);
  }
}

class FetchAllWordsParams{
  final String learningProcessId;

  FetchAllWordsParams({required this.learningProcessId});

}