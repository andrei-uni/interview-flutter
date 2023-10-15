import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/models/enums/habit_priority.dart';
import '../../../../domain/models/enums/habit_type.dart';
import '../json_converters/datetime_converter.dart';
import '../json_converters/habit_priority_converter.dart';
import '../json_converters/habit_type_converter.dart';

part 'add_habit_api.g.dart';

@JsonSerializable()
@DateTimeConverter()
@HabitTypeConverter()
@HabitPriorityConverter()
class AddHabitApi {
  final int color;
  final int count;
  @JsonKey(name: "date")
  final DateTime createdAt;
  final String description;
  @JsonKey(name: "frequency")
  final DateTime completeUntil;
  final HabitPriority priority;
  final String title;
  final HabitType type;

  AddHabitApi({
    required this.color,
    required this.count,
    required this.createdAt,
    required this.description,
    required this.completeUntil,
    required this.priority,
    required this.title,
    required this.type,
  });

  factory AddHabitApi.fromJson(Map<String, dynamic> json) => _$AddHabitApiFromJson(json);

  Map<String, dynamic> toJson() => _$AddHabitApiToJson(this);
}
