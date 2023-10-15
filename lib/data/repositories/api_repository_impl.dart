import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import '../../domain/exceptions/api_exception.dart';
import '../../domain/models/habit.dart';
import '../../domain/models/requests/get_habits_request.dart';
import '../../domain/repositories/api_repository.dart';
import '../../utils/result.dart';
import '../datasources/remote/models/add_habit_api.dart';
import '../datasources/remote/models/get_habits_api.dart';
import '../datasources/remote/models/habit_api.dart';
import '../datasources/remote/models/habit_done_api.dart';
import '../datasources/remote/habits_api_service.dart';
import '../mappers/habit_mapper.dart';

class ApiRepositoryImpl extends ApiRepository {
  final HabitsApiService _habitsApiService;

  ApiRepositoryImpl(this._habitsApiService);

  Future<Result<T, ApiException>> _handler<T>(
    Future<HttpResponse<dynamic>> Function() request,
    T Function(Response<dynamic> response) onSuccess,
  ) async {
    try {
      final response = await request();
      return Success(onSuccess(response.response));
    } on DioException catch (e) {
      final response = e.response;
      return Failure(
        response == null ? NoInternetConnection() : ApiException.fromStatusCode(response.statusCode),
      );
    }
  }

  @override
  Future<Result<Habit, ApiException>> addHabit(Habit habit) async {
    return await _handler(
      () async {
        return await _habitsApiService.addHabit(
          AddHabitApi(
            color: habit.color,
            count: habit.count,
            createdAt: habit.createdAt,
            description: habit.description,
            completeUntil: habit.completeUntil,
            priority: habit.priority,
            title: habit.title,
            type: habit.type,
          ),
        );
      },
      (response) => HabitMapper.fromApi(HabitApi.fromJson(response.data)),
    );
  }

  @override
  Future<Result<Nothing, ApiException>> completeHabit(Habit habit, DateTime date) async {
    return await _handler(
      () async => await _habitsApiService.completeHabit(habit.uid, HabitDoneApi(date: date)),
      (response) => Nothing(),
    );
  }

  @override
  Future<Result<Nothing, ApiException>> updateHabit(Habit habit) async {
    return await _handler(
      () async {
        return await _habitsApiService.updateHabit(
          habit.uid,
          AddHabitApi(
            color: habit.color,
            count: habit.count,
            createdAt: habit.createdAt,
            description: habit.description,
            completeUntil: habit.completeUntil,
            priority: habit.priority,
            title: habit.title,
            type: habit.type,
          ),
        );
      },
      (response) => Nothing(),
    );
  }

  @override
  Future<Result<Nothing, ApiException>> deleteHabit(Habit habit) async {
    return await _handler(
      () async => await _habitsApiService.deleteHabit(habit.uid),
      (response) => Nothing(),
    );
  }

  @override
  Future<Result<GetHabitsApi, ApiException>> getHabits(GetHabitsRequest request) async {
    return await _handler(
      () async => await _habitsApiService.getHabits(
        request.offset,
        request.limit,
        request.title,
        request.orderBy,
        request.orderDirection,
      ),
      (response) {
        return GetHabitsApi.fromJson(response.data);
      },
    );
  }
}
