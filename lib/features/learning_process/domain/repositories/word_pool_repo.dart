import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/features/learning_process/domain/entities/word_pool.dart';

abstract interface class WordPoolRepo {
  Future<Either<Failure,WordPool>> uploadToWordPool({
    required String word,
    required String meaning,
    required String type,
    required String synonym,
    required String sentence
  });
}