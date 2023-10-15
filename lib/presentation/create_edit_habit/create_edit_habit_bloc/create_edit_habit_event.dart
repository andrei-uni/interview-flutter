part of 'create_edit_habit_bloc.dart';

sealed class CreateEditHabitEvent extends Equatable {
  const CreateEditHabitEvent();

  @override
  List<Object> get props => [];
}

final class TitleChanged extends CreateEditHabitEvent {
  const TitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

final class DescriptionChanged extends CreateEditHabitEvent {
  const DescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

final class PriorityChanged extends CreateEditHabitEvent {
  const PriorityChanged(this.priority);

  final HabitPriority priority;

  @override
  List<Object> get props => [priority];
}

final class TypeChanged extends CreateEditHabitEvent {
  const TypeChanged(this.type);

  final HabitType type;

  @override
  List<Object> get props => [type];
}

final class CountChanged extends CreateEditHabitEvent {
  const CountChanged(this.count);

  final String count;

  @override
  List<Object> get props => [count];
}

final class CompleteUntilChanged extends CreateEditHabitEvent {
  const CompleteUntilChanged(this.completeUntil);

  final DateTime completeUntil;

  @override
  List<Object> get props => [completeUntil];
}
