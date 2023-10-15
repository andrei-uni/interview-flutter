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

  HabitsState copyWith({
    List<Habit>? habits,
    String? messageToDisplay,
    bool? hasReachedMax,
    HabitsStatus? status,
  }) {
    return HabitsState(
      habits: habits ?? this.habits,
      messageToDisplay: messageToDisplay,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }
}

enum HabitsStatus {
  loaded,
  loading,
}
