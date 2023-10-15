import 'package:floor/floor.dart';

import '../../../../domain/models/enums/habit_type.dart';

class HabitTypeConverter extends TypeConverter<HabitType, int> {
  @override
  HabitType decode(int databaseValue) {
    return HabitType.values[databaseValue];
  }

  @override
  int encode(HabitType value) {
    return value.index;
  }
}
