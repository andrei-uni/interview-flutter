import '../../domain/models/enums/habit_type.dart';
import '../../domain/models/habit.dart';

extension HabitsFilter on List<Habit> {
  List<Habit> filterByType(HabitType habitType) {
    return where((e) => e.type == habitType).toList();
  }
}