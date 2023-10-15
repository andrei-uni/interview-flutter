import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/models/enums/habit_type.dart';

class HabitTypeConverter implements JsonConverter<HabitType, int> {
  const HabitTypeConverter();

  @override
  HabitType fromJson(int json) {
    return HabitType.values[json];
  }

  @override
  int toJson(HabitType object) {
    return object.index;
  }
}
