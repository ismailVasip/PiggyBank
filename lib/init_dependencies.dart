import 'package:get_it/get_it.dart';
import 'package:piggy_bank/features/learning_process/data/datasources/create_learning_process_remote_date_source.dart';
import 'package:piggy_bank/features/learning_process/data/datasources/to_word_pool_remote_data_sources.dart';
import 'package:piggy_bank/features/learning_process/data/repositories/learning_process_repo_imp.dart';
import 'package:piggy_bank/features/learning_process/data/repositories/word_pool_repo_imp.dart';
import 'package:piggy_bank/features/learning_process/domain/repositories/learning_process_repo.dart';
import 'package:piggy_bank/features/learning_process/domain/repositories/word_pool_repo.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/create_learning_process.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/upload_to_word_pool.dart';
import 'package:piggy_bank/features/learning_process/presentation/bloc/bloc_learning_process/learning_process_bloc.dart';
import 'package:piggy_bank/features/learning_process/presentation/bloc/wordpool_bloc_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:piggy_bank/core/secret/app_secret.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initUploadToWordPool();
  _initCreateLearningProcess();

  final supabase = await Supabase.initialize(
    url: AppSecret.supabaseUrl,
    anonKey: AppSecret.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initUploadToWordPool() {
  serviceLocator
    ..registerFactory<WordPoolRemoteDataSource>(
      () => WordPoolRemoteDataSourceImp(serviceLocator()),
    )
    ..registerFactory<WordPoolRepo>(() => WordPoolRepoImp(serviceLocator()))
    ..registerFactory(() => UploadToWordPool(serviceLocator()))
    ..registerLazySingleton(() => WordpoolBlocBloc(serviceLocator()));
}
void _initCreateLearningProcess(){
  serviceLocator..registerFactory<CreateLearningProcessRemoteDateSource>(
    () => CreateLearningProcessRemoteDateSourceImp(serviceLocator()),
  )
  ..registerFactory<LearningProcessRepo>(
    () => LearningProcessRepoImp(serviceLocator())
  )
  ..registerFactory(()=> CreateLearningProcess(serviceLocator()))
  ..registerLazySingleton(() => LearningProcessBloc(serviceLocator()))
  ;
  
}
