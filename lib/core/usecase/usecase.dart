import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/failures.dart';

abstract interface class UseCase<SuccessType,Params>{
  Future<Either<Failure,SuccessType>> call(Params params);
}
class NoParams{}