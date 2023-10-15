import '../../data/datasources/remote/models/get_habits_api.dart';
import '../../utils/result.dart';
import '../exceptions/api_exception.dart';
import '../models/habit.dart';
import '../models/requests/get_habits_request.dart';

abstract class ApiRepository {
  Future<Result<Habit, ApiException>> addHabit(Habit habit);

  Future<Result<Nothing, ApiException>> updateHabit(Habit habit);

  Future<Result<Nothing, ApiException>> completeHabit(Habit habit, DateTime date);

  Future<Result<Nothing, ApiException>> deleteHabit(Habit habit);

  Future<Result<GetHabitsApi, ApiException>> getHabits(GetHabitsRequest request);
}
