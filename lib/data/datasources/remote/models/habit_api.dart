import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/models/enums/habit_priority.dart';
import '../../../../domain/models/enums/habit_type.dart';
import '../json_converters/datetime_converter.dart';
import '../json_converters/habit_priority_converter.dart';
import '../json_converters/habit_type_converter.dart';

part 'habit_api.g.dart';

@JsonSerializable()
@DateTimeConverter()
@HabitTypeConverter()
@HabitPriorityConverter()
class HabitApi {
  final int color;
  final int count;
  @JsonKey(name: "date")
  final DateTime createdAt;
  final String description;
  @JsonKey(name: "done_dates")
  final List<DateTime>? doneDates;
  @JsonKey(name: "frequency")
  final DateTime completeUntil;
  final HabitPriority priority;
  final String title;
  final HabitType type;
  final String uid;

  HabitApi({
    required this.color,
    required this.count,
    required this.createdAt,
    required this.description,
    required this.doneDates,
    required this.completeUntil,
    required this.priority,
    required this.title,
    required this.type,
    required this.uid,
  });

  factory HabitApi.fromJson(Map<String, dynamic> json) => _$HabitApiFromJson(json);

  Map<String, dynamic> toJson() => _$HabitApiToJson(this);
}
