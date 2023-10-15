import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/models/enums/habit_priority.dart';

class HabitPriorityConverter implements JsonConverter<HabitPriority, int> {
  const HabitPriorityConverter();
  
  @override
  HabitPriority fromJson(int json) {
    return HabitPriority.values[json];
  }
  
  @override
  int toJson(HabitPriority object) {
    return object.index;
  }
}