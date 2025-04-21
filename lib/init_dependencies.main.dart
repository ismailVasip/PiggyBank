part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initUploadToWordPool();
  _initCreateLearningProcess();

  final supabase = await Supabase.initialize(
    url: AppSecret.supabaseUrl,
    anonKey: AppSecret.supabaseAnonKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(
    () => Hive.box(name: 'LearningProcess'),
    instanceName: 'LearningProcess',
  );
  serviceLocator.registerLazySingleton(
    () => Hive.box(name: 'WordPool'),
    instanceName: 'WordPool',
  );
  serviceLocator.registerLazySingleton(
    () => Hive.box(name: 'PiggyBank'),
    instanceName: 'PiggyBank',
  );

  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(() => LocaleManager());

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImp(serviceLocator()),
  );
}

void _initUploadToWordPool() {
  serviceLocator
    ..registerFactory<WordPoolRemoteDataSource>(
      () => WordPoolRemoteDataSourceImp(serviceLocator()),
    )
    ..registerFactory<LearningProcessLocaleDataSource>(
      () => LearningProcessLocaleDataSourceImp(
        serviceLocator<Box>(instanceName: 'PiggyBank'),
        serviceLocator<Box>(instanceName: 'WordPool'),
      ),
    )
    ..registerFactory<WordPoolRepo>(
      () => WordPoolRepoImp(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory(() => UploadToWordPool(serviceLocator()))
    ..registerFactory(() => FetchSummary(serviceLocator()))
    ..registerFactory(() => FetchAllWords(serviceLocator()))
    ..registerFactory(() => RemoveWord(serviceLocator()))
    ..registerFactory(() => AddToPiggyBank(serviceLocator()))
    ..registerLazySingleton(
      () => LearningProcessBloc(
        uploadToWordPool: serviceLocator(),
        fetchSummary: serviceLocator(),
        fetchAllWords: serviceLocator(),
        removeWord: serviceLocator(),
        addToPiggyBank: serviceLocator(),
      ),
    );
}

void _initCreateLearningProcess() {
  serviceLocator
    ..registerFactory<CreateLearningProcessRemoteDateSource>(
      () => CreateLearningProcessRemoteDateSourceImp(serviceLocator()),
    )
    ..registerFactory<HomeLocalDataSource>(
      () => HomeLocalDataSourceImp(
        serviceLocator<Box>(instanceName: 'LearningProcess'),
      ),
    )
    ..registerFactory<LearningProcessRepo>(
      () => LearningProcessRepoImp(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory(() => CreateLearningProcess(serviceLocator()))
    ..registerFactory(() => GetAllProcesses(serviceLocator()))
    ..registerFactory(() => DeleteProcess(serviceLocator()))
    ..registerLazySingleton(
      () => HomeBloc(
        createLearningProcess: serviceLocator(),
        getAllProcesses: serviceLocator(),
        deleteProcess: serviceLocator(),
      ),
    );
}
