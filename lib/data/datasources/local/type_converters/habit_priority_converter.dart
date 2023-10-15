import 'package:floor/floor.dart';

import '../../../../domain/models/enums/habit_priority.dart';

class HabitPriorityConverter extends TypeConverter<HabitPriority, int> {
  @override
  HabitPriority decode(int databaseValue) {
    return HabitPriority.values[databaseValue];
  }

  @override
  int encode(HabitPriority value) {
    return value.index;
  }
}
