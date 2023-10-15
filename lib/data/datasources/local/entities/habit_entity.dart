import 'package:floor/floor.dart';

import '../../../../domain/models/enums/habit_priority.dart';
import '../../../../domain/models/enums/habit_type.dart';

@entity
class HabitEntity {
  @primaryKey
  final String uid;

  final String title;
  final String description;
  final HabitPriority priority;
  final int count;
  final HabitType type;
  final DateTime completeUntil;
  final DateTime createdAt;
  final int color;

  HabitEntity({
    required this.uid,
    required this.title,
    required this.description,
    required this.priority,
    required this.count,
    required this.type,
    required this.completeUntil,
    required this.createdAt,
    required this.color,
  });
}
