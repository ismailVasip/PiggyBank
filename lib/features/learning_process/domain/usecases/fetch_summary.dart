
import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/core/usecase/usecase.dart';
import 'package:piggy_bank/features/learning_process/domain/repositories/word_pool_repo.dart';

class FetchSummary implements UseCase<(String?,int),FetchSummaryParams>{
  final WordPoolRepo _wordPoolRepo;

  FetchSummary(this._wordPoolRepo);

  @override
  Future<Either<Failure, (String?, int)>> call(FetchSummaryParams params) async{
    return await _wordPoolRepo.fetchLearningProcessSummary(params.processId,params.isItLearned);
  }
}
class FetchSummaryParams{
  final String processId;
  final bool isItLearned;

  FetchSummaryParams({required this.processId,required this.isItLearned});
}