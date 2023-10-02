import 'package:get_it/get_it.dart';

import 'src/models/database/my_database.dart';
import 'src/models/datasource/local/student_local_datasource.dart';
import 'src/models/repository/student_repository.dart';
import 'src/view_model/app_config_cubit.dart';
import 'src/view_model/student_cubit.dart';

final getIt = GetIt.instance;

void setupInjection() {
  // Register your dependencies here

  // Cubits
  getIt.registerFactory(() => AppConfigCubit());
  getIt.registerFactory(() => StudentCubit(repository: getIt()));

  // Repositories
  getIt.registerLazySingleton(
    () => StudentRepository(
      localDatasource: getIt(),
    ),
  );

  // Local Datasources
  getIt.registerLazySingleton(() => StudentLocalDatasource(database: getIt()));

  // Utils
  getIt.registerLazySingleton(() => MyDatabase());
}
