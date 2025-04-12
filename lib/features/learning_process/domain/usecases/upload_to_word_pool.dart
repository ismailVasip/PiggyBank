import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/core/usecase/usecase.dart';
import 'package:piggy_bank/features/learning_process/domain/entities/word_pool.dart';
import 'package:piggy_bank/features/learning_process/domain/repositories/word_pool_repo.dart';

class UploadToWordPool implements UseCase<WordPool, UploadToWordPoolParams> {
  final WordPoolRepo wordPoolRepo;
  UploadToWordPool(this.wordPoolRepo);

  @override
  Future<Either<Failure, WordPool>> call(UploadToWordPoolParams params) async {
    return await wordPoolRepo.uploadToWordPool(
      word: params.word,
      meaning: params.meaning,
      type: params.type,
      synonym: params.synonym,
      sentence: params.sentence,
      learningProcessId: params.learningProcessId,
      isItLearned: params.isItLearned
    );
  }
}

class UploadToWordPoolParams {
  final String word;
  final String meaning;
  final String type;
  final String synonym;
  final String sentence;
  final String learningProcessId;
  final bool isItLearned;

  UploadToWordPoolParams({
    required this.word,
    required this.meaning,
    required this.type,
    required this.synonym,
    required this.sentence,
    required this.learningProcessId,
    required this.isItLearned
  });
}
