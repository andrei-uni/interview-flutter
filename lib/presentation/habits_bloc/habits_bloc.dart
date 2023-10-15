import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';

import '../../data/repositories/app_repository.dart';
import '../../domain/models/enums/habit_type.dart';
import '../../domain/models/habit.dart';
import 'habits_fetcher.dart';
import '../habits_search/sort_by_date.dart';

part 'habits_event.dart';
part 'habits_state.dart';

enum AppStatus {
  usual,
  searching,
}

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  final AppRepository _appRepository;

  HabitsBloc(this._appRepository)
      : _habitsFetcher = HabitsFetcher(_appRepository),
        super(const HabitsState(habits: [], status: HabitsStatus.loading)) {
    on<GetHabits>(
      _onGetHabits,
      transformer: (events, mapper) => events.throttleTime(const Duration(milliseconds: 100)).switchMap(mapper),
    );
    on<AddNewHabit>(_onAddNewHabit);
    on<EditHabit>(_onEditHabit);
    on<CompleteHabit>(_onCompleteHabit);
    on<SearchSubmitted>(_onSearchSubmitted);
    on<SearchCancelled>(_onSearchCancelled);  
  }

  var _appStatus = AppStatus.usual;
  final HabitsFetcher _habitsFetcher;
  late String _title;
  late SortByDate _sortByDate;

  void _onGetHabits(GetHabits event, Emitter<HabitsState> emit) async {
    final result = await switch (_appStatus) {
      AppStatus.usual => _habitsFetcher.fetchHabits(),
      AppStatus.searching => _habitsFetcher.fetchHabits(title: _title, sortByDate: _sortByDate),
    };

    final state = this.state;

    if (result.isFailure) {
      emit(
        HabitsState(
          habits: state.habits,
          messageToDisplay: result.failure.message,
          hasReachedMax: true,
          status: HabitsStatus.failure,
        ),
      );
      return;
    }

    emit(
      HabitsState(
        habits: state.habits + result.success,
        hasReachedMax: result.success.isEmpty,
        status: HabitsStatus.success,
      ),
    );
  }

  void _onAddNewHabit(AddNewHabit event, Emitter<HabitsState> emit) async {
    final result = await _appRepository.addHabit(event.habit);

    if (result.isFailure) {
      emit(HabitsState(habits: state.habits, messageToDisplay: result.failure.message, status: HabitsStatus.success));
      return;
    }

    emit(HabitsState(habits: [result.success] + state.habits, status: HabitsStatus.success));
  }

  void _onEditHabit(EditHabit event, Emitter<HabitsState> emit) async {
    final apiException = await _appRepository.updateHabit(event.habit);
    final state = this.state;
    final habits = state.habits;

    if (apiException != null) {
      emit(HabitsState(habits: habits, messageToDisplay: apiException.message, status: HabitsStatus.success));
      return;
    }

    final index = habits.indexWhere((e) => e.uid == event.habit.uid);
    habits[index] = event.habit;

    emit(HabitsState(habits: habits, status: HabitsStatus.success));
  }

  void _onCompleteHabit(CompleteHabit event, Emitter<HabitsState> emit) async {
    final state = this.state;
    final habits = state.habits;

    if (!event.habit.canStillComplete) {
      emit(
        HabitsState(
          habits: habits,
          messageToDisplay: _messageAboutHabitCompletion(event.habit),
          status: HabitsStatus.success,
        ),
      );
      return;
    }

    final now = DateTime.now();
    final apiException = await _appRepository.completeHabit(event.habit, now);

    if (apiException != null) {
      emit(HabitsState(habits: habits, messageToDisplay: apiException.message, status: HabitsStatus.success));
      return;
    }

    final newHabit = event.habit.copyWith(doneDates: [...event.habit.doneDates, now]);
    final index = habits.indexWhere((e) => e.uid == event.habit.uid);
    habits[index] = newHabit;

    emit(HabitsState(
        habits: habits, messageToDisplay: _messageAboutHabitCompletion(newHabit), status: HabitsStatus.success));
  }

  void _onSearchSubmitted(SearchSubmitted event, Emitter<HabitsState> emit) {
    _appStatus = AppStatus.searching;
    _habitsFetcher.reset();
    _title = event.query;
    _sortByDate = event.sortByDate;

    emit(
      const HabitsState(
        habits: [],
        hasReachedMax: false,
        status: HabitsStatus.loading,
      ),
    );

    add(GetHabits());
  }

  void _onSearchCancelled(SearchCancelled event, Emitter<HabitsState> emit) {
    _appStatus = AppStatus.usual;
    _habitsFetcher.reset();

    emit(
      const HabitsState(
        habits: [],
        hasReachedMax: false,
        status: HabitsStatus.loading,
      ),
    );

    add(GetHabits());
  }

  static String _messageAboutHabitCompletion(Habit habit) {
    if (!habit.canStillComplete) return "Больше выполнять нельзя :(";

    final currentCount = habit.doneDates.length;
    final goalCount = habit.count;
    final completed = currentCount >= goalCount;

    return switch (habit.type) {
      HabitType.good => completed ? "You are breathtaking!" : "Стоит выполнить еще ${goalCount - currentCount} раз",
      HabitType.bad => completed ? "Хватит это делать" : "Можете выполнить еще ${goalCount - currentCount} раз",
    };
  }
}
