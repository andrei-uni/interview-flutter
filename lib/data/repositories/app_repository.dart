import '../../domain/exceptions/api_exception.dart';
import '../../domain/models/habit.dart';
import '../../domain/models/requests/get_habits_request.dart';
import '../../domain/repositories/api_repository.dart';
import '../../domain/repositories/database_repository.dart';
import '../../utils/result.dart';
import '../datasources/remote/models/get_habits_api.dart';

class AppRepository {
  final ApiRepository _apiRepository;
  final DatabaseRepository _databaseRepository;

  AppRepository(this._apiRepository, this._databaseRepository);

  Future<ApiException?> updateHabit(Habit habit) async {
    final result = await _apiRepository.updateHabit(habit);

    if (result.isFailure) return result.failure;

    await _databaseRepository.updateHabit(habit);

    return null;
  }

  Future<Result<Habit, ApiException>> addHabit(Habit habit) async {
    final result = await _apiRepository.addHabit(habit);

    if (result.isFailure) return Failure(result.failure);

    final newHabit = result.success;

    await _databaseRepository.addHabit(newHabit);

    return Success(newHabit);
  }

  Future<ApiException?> completeHabit(Habit habit, DateTime dateTime) async {
    final result = await _apiRepository.completeHabit(habit, dateTime);

    if (result.isFailure) return result.failure;

    await _databaseRepository.completeHabit(habit, dateTime);

    return null;
  }

  Future<Result<GetHabitsApi, ApiException>> getHabits(GetHabitsRequest request) async {
    final result = await _apiRepository.getHabits(request);

    if (result.isFailure) return Failure(result.failure);

    return Success(result.success);
  }
}
