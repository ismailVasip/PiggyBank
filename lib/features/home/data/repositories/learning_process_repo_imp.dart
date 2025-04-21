import 'package:fpdart/fpdart.dart';
import 'package:piggy_bank/core/error/exceptions.dart';
import 'package:piggy_bank/core/error/failures.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/network/connection_checker.dart';
import 'package:piggy_bank/features/home/data/datasources/create_learning_process_locale_datesource.dart';
import 'package:piggy_bank/features/home/data/datasources/create_learning_process_remote_date_source.dart';
import 'package:piggy_bank/features/home/data/models/learning_process_model.dart';
import 'package:piggy_bank/features/home/domain/entities/learning_process.dart';
import 'package:piggy_bank/features/home/domain/repositories/learning_process_repo.dart';
import 'package:uuid/uuid.dart';

class LearningProcessRepoImp implements LearningProcessRepo {
  final CreateLearningProcessRemoteDateSource learningProcessRemoteDataSource;
  final ConnectionChecker connectionChecker;
  final HomeLocalDataSource homeLocalDataSource;
  final LocaleManager localeManager;
  LearningProcessRepoImp(
    this.learningProcessRemoteDataSource,
    this.connectionChecker,
    this.homeLocalDataSource,
    this.localeManager
  );

  @override
  Future<Either<Failure, LearningProcess>> createLearningProcess({
    required String title,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(
          Failure(
            localeManager.translate('NoInternetConnectionText'),
          ),
        );
      }
      LearningProcessModel learningProcessModel = LearningProcessModel(
        id: Uuid().v1(),
        title: title,
        updatedAt: DateTime.now(),
      );

      final model = await learningProcessRemoteDataSource.createLearningProcess(
        learningProcessModel,
      );

      return right(model);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<LearningProcess>>> getAllProcesses() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final processes = homeLocalDataSource.loadLocalLProcesses();
        return right(processes);
      }
      final allProcesses =
          await learningProcessRemoteDataSource.getAllProcesses();

      homeLocalDataSource.uploadLocalLProcesses(processes:allProcesses);

      return right(allProcesses);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProcess(String processId) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(
          Failure(
            localeManager.translate('NoInternetConnectionText'),
          ),
        );
      }
      final result = await learningProcessRemoteDataSource.deleteProcess(
        processId,
      );

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
