import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/core/usecase/usecase.dart';
import 'package:piggy_bank/features/learning_process/domain/repositories/word_pool_repo.dart';

class AddToPiggyBank implements UseCase<bool,AddToPiggyBankParams>{
  final WordPoolRepo _wordPoolRepo;

  AddToPiggyBank(this._wordPoolRepo);
  @override
  Future<Either<Failure, bool>> call(AddToPiggyBankParams params) async{
    return await _wordPoolRepo.addToPiggyBank(params.id) ;
  }
}

class AddToPiggyBankParams{
  final String id;

  AddToPiggyBankParams({required this.id});
}