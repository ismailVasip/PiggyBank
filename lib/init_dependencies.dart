import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/network/connection_checker.dart';
import 'package:piggy_bank/features/home/data/datasources/create_learning_process_locale_datesource.dart';
import 'package:piggy_bank/features/home/data/datasources/create_learning_process_remote_date_source.dart';
import 'package:piggy_bank/features/home/domain/usecases/delete_process.dart';
import 'package:piggy_bank/features/home/presentation/bloc/home_bloc.dart';
import 'package:piggy_bank/features/learning_process/data/datasources/learning_process_locale_data_source.dart';
import 'package:piggy_bank/features/learning_process/data/datasources/learning_process_remote_data_sources.dart';
import 'package:piggy_bank/features/home/data/repositories/learning_process_repo_imp.dart';
import 'package:piggy_bank/features/learning_process/data/repositories/word_pool_repo_imp.dart';
import 'package:piggy_bank/features/home/domain/repositories/learning_process_repo.dart';
import 'package:piggy_bank/features/learning_process/domain/repositories/word_pool_repo.dart';
import 'package:piggy_bank/features/home/domain/usecases/create_learning_process.dart';
import 'package:piggy_bank/features/home/domain/usecases/get_all_processes.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/add_to_piggybank.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/fetch_all_words.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/fetch_summary.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/remove_word.dart';
import 'package:piggy_bank/features/learning_process/domain/usecases/upload_to_word_pool.dart';
import 'package:piggy_bank/features/learning_process/presentation/bloc/learning_process_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:piggy_bank/core/secret/app_secret.dart';

part 'init_dependencies.main.dart';