import 'package:equatable/equatable.dart';

import 'enums/habit_priority.dart';
import 'enums/habit_type.dart';

class Habit extends Equatable {
  final String uid;
  final String title;
  final String description;
  final HabitPriority priority;
  final int count;
  final HabitType type;
  final DateTime completeUntil;
  final DateTime createdAt;
  final List<DateTime> doneDates;
  final int color;

  const Habit({
    required this.uid,
    required this.title,
    required this.description,
    required this.priority,
    required this.count,
    required this.type,
    required this.completeUntil,
    required this.createdAt,
    required this.doneDates,
    required this.color,
  });

  @override
  List<Object?> get props => [uid, title, description, priority, count, type, completeUntil, createdAt, doneDates, color];

  Habit copyWith({
    String? uid,
    String? title,
    String? description,
    HabitPriority? priority,
    int? count,
    HabitType? type,
    DateTime? completeUntil,
    DateTime? createdAt,
    List<DateTime>? doneDates,
    int? color,
  }) {
    return Habit(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      count: count ?? this.count,
      type: type ?? this.type,
      completeUntil: completeUntil ?? this.completeUntil,
      createdAt: createdAt ?? this.createdAt,
      doneDates: doneDates ?? this.doneDates,
      color: color ?? this.color,
    );
  }

  bool get canStillComplete => DateTime.now().isBefore(completeUntil);
}
