import 'package:json_annotation/json_annotation.dart';

import 'habit_api.dart';

part 'get_habits_api.g.dart';

@JsonSerializable()
class GetHabitsApi {
  final int count;
  final List<HabitApi>? habits;

  GetHabitsApi({
    required this.count,
    required this.habits,
  });

  factory GetHabitsApi.fromJson(Map<String, dynamic> json) => _$GetHabitsApiFromJson(json);

  Map<String, dynamic> toJson() => _$GetHabitsApiToJson(this);
}
