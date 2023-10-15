import '../../data/mappers/habit_mapper.dart';
import '../../data/repositories/app_repository.dart';
import '../../domain/exceptions/api_exception.dart';
import '../../domain/models/habit.dart';
import '../../domain/models/requests/get_habits_request.dart';
import '../../utils/result.dart';
import '../habits_search/sort_by_date.dart';

class HabitsFetcher {
  final AppRepository _appRepository;

  HabitsFetcher(this._appRepository);

  static const _limit = 5;
  var totalCount = 0;
  var currentCount = 0;
  var firstRun = true;

  Future<Result<(List<Habit> habits, bool hasReachedMax), ApiException>> fetchHabits(
      {String? title, SortByDate? sortByDate}) async {
    if (!firstRun && currentCount >= totalCount) return const Success(([], true));

    final result = await _appRepository.getHabits(
      GetHabitsRequest(
        offset: currentCount,
        limit: _limit,
        title: title,
        orderBy: title == null ? null : 'date',
        orderDirection: sortByDate?.toApiString,
      ),
    );

    if (result.isFailure) return Failure(result.failure);

    firstRun = false;
    final habits = result.success;
    totalCount = habits.count;

    if (habits.habits == null) return const Success(([], true));

    currentCount += habits.habits!.length;

    return Success((
      habits.habits!.map((e) => HabitMapper.fromApi(e)).toList(),
      currentCount < _limit
    ));
  }

  void reset() {
    totalCount = 0;
    currentCount = 0;
    firstRun = true;
  }
}
