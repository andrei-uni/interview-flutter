import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../domain/models/enums/habit_priority.dart';
import '../../../domain/models/enums/habit_type.dart';
import '../../../domain/models/habit.dart';
import 'formz_models/count.dart';
import 'formz_models/non_empty_text.dart';

part 'create_edit_habit_event.dart';
part 'create_edit_habit_state.dart';

class CreateEditHabitBloc extends Bloc<CreateEditHabitEvent, CreateEditHabitState> {
  CreateEditHabitBloc(this._habitToEdit)
      : super(CreateEditHabitState(
          title: NonEmptyText.pure(_habitToEdit?.title ?? ""),
          description: NonEmptyText.pure(_habitToEdit?.description ?? ""),
          habitPriority: _habitToEdit?.priority ?? HabitPriority.low,
          habitType: _habitToEdit?.type ?? HabitType.good,
          count: Count.pure(_habitToEdit?.count.toString() ?? ""),
          completeUntil: _habitToEdit?.completeUntil ?? DateTime.now().add(const Duration(days: 7)),
        )) {
    on<TitleChanged>(_onTitleChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<PriorityChanged>(_onPriorityChanged);
    on<TypeChanged>(_onTypeChanged);
    on<CountChanged>(_onCountChanged);
    on<CompleteUntilChanged>(_onCompleteUntilChanged);
  }

  final Habit? _habitToEdit;

  void _onTitleChanged(TitleChanged event, Emitter<CreateEditHabitState> emit) {
    final title = NonEmptyText.dirty(event.title);
    emit(state.copyWith(title: title));
  }

  void _onDescriptionChanged(DescriptionChanged event, Emitter<CreateEditHabitState> emit) {
    final description = NonEmptyText.dirty(event.description);
    emit(state.copyWith(description: description));
  }

  void _onPriorityChanged(PriorityChanged event, Emitter<CreateEditHabitState> emit) {
    emit(state.copyWith(habitPriority: event.priority));
  }

  void _onTypeChanged(TypeChanged event, Emitter<CreateEditHabitState> emit) {
    emit(state.copyWith(habitType: event.type));
  }

  void _onCountChanged(CountChanged event, Emitter<CreateEditHabitState> emit) {
    final count = Count.dirty(event.count);
    emit(state.copyWith(count: count));
  }

  void _onCompleteUntilChanged(CompleteUntilChanged event, Emitter<CreateEditHabitState> emit) {
    emit(state.copyWith(completeUntil: event.completeUntil));
  }

  Habit getNewHabit() {
    final state = this.state;

    final title = state.title.value;
    final description = state.description.value;
    final priority = state.habitPriority;
    final type = state.habitType;
    final count = int.parse(state.count.value);
    final completeUntil = state.completeUntil;

    if (_habitToEdit == null) {
      return Habit(
        uid: "",
        title: title.trim(),
        description: description.trim(),
        priority: priority,
        count: count,
        type: type,
        completeUntil: completeUntil,
        createdAt: DateTime.now(),
        doneDates: const [],
        color: 0,
      );
    }

    return _habitToEdit!.copyWith(
      title: title.trim(),
      description: description.trim(),
      priority: priority,
      type: type,
      count: count,
      completeUntil: completeUntil,
      createdAt: DateTime.now(),
    );
  }
}
