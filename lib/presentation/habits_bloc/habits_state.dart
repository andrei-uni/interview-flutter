part of 'habits_bloc.dart';

class HabitsState {
  const HabitsState({
    required this.habits,
    this.messageToDisplay,
    this.hasReachedMax = false,
    required this.status,
  });

  final List<Habit> habits;
  final String? messageToDisplay;
  final bool hasReachedMax;
  final HabitsStatus status;
}

enum HabitsStatus {
  failure,
  success,
  loading,
}
