import 'package:floor/floor.dart';

import '../entities/habit_entity.dart';

@dao
abstract class HabitDao {
  @Query('SELECT * FROM HabitEntity')
  Future<List<HabitEntity>> getAllHabits();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHabit(HabitEntity habit);

  @update
  Future<void> updateHabit(HabitEntity habit);
}
