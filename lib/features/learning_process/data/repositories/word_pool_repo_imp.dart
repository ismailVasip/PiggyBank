import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/exceptions.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/features/learning_process/data/datasources/to_word_pool_remote_data_sources.dart';
import 'package:piggy_bank/features/learning_process/data/models/word_pool_model.dart';
import 'package:piggy_bank/features/learning_process/domain/entities/word_pool.dart';
import 'package:piggy_bank/features/learning_process/domain/repositories/word_pool_repo.dart';
import 'package:uuid/uuid.dart';

class WordPoolRepoImp implements WordPoolRepo {
  final WordPoolRemoteDataSource wordPoolRemoteDataSource;
    WordPoolRepoImp(this.wordPoolRemoteDataSource);

  @override
  Future<Either<Failure, WordPool>> uploadToWordPool({
    required String word,
    required String meaning,
    required String type,
    required String synonym,
    required String sentence,
  }) async {
    try{
      WordPoolModel wordPoolModel = WordPoolModel(
      id: Uuid().v1(),
      word: word,
      meaning: meaning,
      type: type,
      synonym: synonym,
      sentence: sentence,
      updatedAt: DateTime.now(),
    );

    final uploadToWordPool = await wordPoolRemoteDataSource.uploadToWordPool(wordPoolModel);

    return right(uploadToWordPool);
    
    }on ServerException catch(e){
      return left(Failure(e.message));
    }
  }
}
