import '../../domain/models/habit.dart';
import '../../domain/repositories/database_repository.dart';
import '../datasources/local/app_database.dart';
import '../datasources/local/entities/habit_done_dates_entity.dart';
import '../mappers/habit_mapper.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final AppDatabase _appDatabase;

  DatabaseRepositoryImpl(this._appDatabase);

  @override
  Future<void> addHabit(Habit habit) async {
    await _appDatabase.habitDao.insertHabit(HabitMapper.toEntity(habit));
    for (final doneDate in habit.doneDates) {
      await _appDatabase.habitDoneDatesDao.insertDoneDate(HabitDoneDatesEntity(uid: habit.uid, date: doneDate));
    }
  }

  @override
  Future<void> completeHabit(Habit habit, DateTime date) async {
    await _appDatabase.habitDoneDatesDao.insertDoneDate(HabitDoneDatesEntity(uid: habit.uid, date: date));
  }

  @override
  Future<List<Habit>> getAllHabits() async {
    final result = <Habit>[];

    final habits = await _appDatabase.habitDao.getAllHabits();

    for (final habitEntity in habits) {
      final doneDates = await _appDatabase.habitDoneDatesDao.findByHabitUid(habitEntity.uid);
      result.add(HabitMapper.fromEntity(habitEntity, doneDates));
    }

    return result;
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    await _appDatabase.habitDao.updateHabit(HabitMapper.toEntity(habit));
  }

  @override
  Future<int> habitCompletedCount(Habit habit) async {
    final dates = await _appDatabase.habitDoneDatesDao.findByHabitUid(habit.uid);
    return dates.length;
  }
}
