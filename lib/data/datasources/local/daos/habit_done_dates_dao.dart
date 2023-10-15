import 'package:floor/floor.dart';

import '../entities/habit_done_dates_entity.dart';

@dao
abstract class HabitDoneDatesDao {
  @Query('SELECT * FROM HabitDoneDatesEntity WHERE uid = :uid')
  Future<List<HabitDoneDatesEntity>> findByHabitUid(String uid);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDoneDate(HabitDoneDatesEntity habitDoneDatesEntity);
}
