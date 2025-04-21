import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/exceptions.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/network/connection_checker.dart';
import 'package:piggy_bank/features/learning_process/data/datasources/learning_process_locale_data_source.dart';
import 'package:piggy_bank/features/learning_process/data/datasources/learning_process_remote_data_sources.dart';
import 'package:piggy_bank/features/learning_process/data/models/word_pool_model.dart';
import 'package:piggy_bank/features/learning_process/domain/entities/word_pool.dart';
import 'package:piggy_bank/features/learning_process/domain/repositories/word_pool_repo.dart';
import 'package:uuid/uuid.dart';

class WordPoolRepoImp implements WordPoolRepo {
  final WordPoolRemoteDataSource wordPoolRemoteDataSource;
  final ConnectionChecker connectionChecker;
  final LearningProcessLocaleDataSource localeDataSource;
  final LocaleManager localeManager;
  WordPoolRepoImp(
    this.wordPoolRemoteDataSource,
    this.connectionChecker,
    this.localeDataSource,
    this.localeManager,
  );

  @override
  Future<Either<Failure, WordPool>> uploadToWordPool({
    required String word,
    required String meaning,
    required String type,
    required String synonym,
    required String sentence,
    required String learningProcessId,
    required bool isItLearned,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(
          Failure(localeManager.translate('NoInternetConnectionText')),
        );
      }
      WordPoolModel wordPoolModel = WordPoolModel(
        id: Uuid().v1(),
        word: word,
        meaning: meaning,
        type: type,
        synonym: synonym,
        sentence: sentence,
        updatedAt: DateTime.now(),
        learningProccessId: learningProcessId,
        isItLearned: isItLearned,
      );

      final uploadToWordPool = await wordPoolRemoteDataSource.uploadToWordPool(
        wordPoolModel,
      );

      return right(uploadToWordPool);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<WordPool>>> fetchAllWords(
    String learningProcessId,
    bool isItLearned,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        if (isItLearned) {
          final piggyBankList = localeDataSource.loadLocalePiggyBank();
          return right(piggyBankList);
        } else {
          final wordPoolList = localeDataSource.loadLocaleWordPool();
          return right(wordPoolList);
        }
      }
      final allWords = await wordPoolRemoteDataSource.fetchAllWords(
        learningProcessId,
        isItLearned,
      );
      if (isItLearned) {
        localeDataSource.uploadLocalePiggyBank(list: allWords);
      } else {
        localeDataSource.uploadLocaleWordPool(list: allWords);
      }

      return right(allWords);
    } on ServerException catch (e) {
      throw left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, (String?, int)>> fetchLearningProcessSummary(
    String processId,
    bool isItLearned,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        if (isItLearned) {
          return right(localeDataSource.loadPiggyBankSummary());
        } else {
          return right(localeDataSource.loadWordPoolSummary());
        }
      }

      final sumResult = await wordPoolRemoteDataSource
          .fetchLearningProcessSummary(processId, isItLearned);

      return right(sumResult);
    } on ServerException catch (e) {
      throw left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> removeWord(String id) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(
          Failure(localeManager.translate('NoInternetConnectionText')),
        );
      }

      final result = await wordPoolRemoteDataSource.removeWord(id);

      return right(result);
    } on ServerException catch (e) {
      throw left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> addToPiggyBank(String id) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(
          Failure(localeManager.translate('NoInternetConnectionText')),
        );
      }
      final result = await wordPoolRemoteDataSource.addToPiggyBank(id);

      return right(result);
    } on ServerException catch (e) {
      throw left(Failure(e.message));
    }
  }
}
