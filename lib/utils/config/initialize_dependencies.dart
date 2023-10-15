import 'package:dio/dio.dart';

import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/habits_api_service.dart';
import '../../data/repositories/api_repository_impl.dart';
import '../../data/repositories/app_repository.dart';
import '../../data/repositories/database_repository_impl.dart';
import '../constants/api_constants.dart';
import '../constants/db_constants.dart';

Future<AppRepository> initializeDependencies() async {
  final appDatabase = await $FloorAppDatabase.databaseBuilder(DbConstants.dbName).build();
  final databaseRepository = DatabaseRepositoryImpl(appDatabase);

  final dio = Dio(
    BaseOptions(
      headers: {'Authorization': ApiConstants.authToken},
      contentType: 'application/json',
    ),
  );
  final client = HabitsApiService(dio, baseUrl: ApiConstants.baseUrl);
  final apiRepository = ApiRepositoryImpl(client);

  return AppRepository(apiRepository, databaseRepository);
}
