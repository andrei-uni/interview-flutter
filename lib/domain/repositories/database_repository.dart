import '../models/habit.dart';

abstract class DatabaseRepository {
  Future<List<Habit>> getAllHabits();

  Future<void> addHabit(Habit habit);

  Future<void> updateHabit(Habit habit);

  Future<void> completeHabit(Habit habit, DateTime date);

  Future<int> habitCompletedCount(Habit habit);
}
