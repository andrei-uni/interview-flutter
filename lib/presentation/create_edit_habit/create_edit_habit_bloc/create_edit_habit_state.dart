part of 'create_edit_habit_bloc.dart';

final class CreateEditHabitState extends Equatable {
  const CreateEditHabitState({
    required this.title,
    required this.description,
    required this.habitPriority,
    required this.habitType,
    required this.count,
    required this.completeUntil,
  });

  final NonEmptyText title;
  final NonEmptyText description;
  final HabitPriority habitPriority;
  final HabitType habitType;
  final Count count;
  final DateTime completeUntil;

  bool get isValid => Formz.validate([title, description, count]);

  CreateEditHabitState copyWith({
    NonEmptyText? title,
    NonEmptyText? description,
    HabitPriority? habitPriority,
    HabitType? habitType,
    Count? count,
    DateTime? completeUntil,
  }) {
    return CreateEditHabitState(
      title: title ?? this.title,
      description: description ?? this.description,
      habitPriority: habitPriority ?? this.habitPriority,
      habitType: habitType ?? this.habitType,
      count: count ?? this.count,
      completeUntil: completeUntil ?? this.completeUntil,
    );
  }

  @override
  List<Object> get props => [title, description, habitPriority, habitType, count, completeUntil];
}
