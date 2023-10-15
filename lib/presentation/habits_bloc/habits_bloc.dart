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

    if (result.isFailure) {
      emit(
        HabitsState(
          habits: state.habits,
          messageToDisplay: result.failure.message,
          hasReachedMax: true,
          status: HabitsStatus.loaded,
        ),
      );
      return;
    }

    emit(
      HabitsState(
        habits: state.habits + result.success.$1,
        hasReachedMax: result.success.$2,
        status: HabitsStatus.loaded,
      ),
    );
  }

  void _onAddNewHabit(AddNewHabit event, Emitter<HabitsState> emit) async {
    final result = await _appRepository.addHabit(event.habit);

    if (result.isFailure) {
      emit(state.copyWith(messageToDisplay: result.failure.message));
      return;
    }

    _loadAgain(emit);
  }

  void _onEditHabit(EditHabit event, Emitter<HabitsState> emit) async {
    final apiException = await _appRepository.updateHabit(event.habit);

    if (apiException != null) {
      emit(state.copyWith(messageToDisplay: apiException.message));
      return;
    }

    final habits = state.habits;

    final index = habits.indexWhere((e) => e.uid == event.habit.uid);
    habits[index] = event.habit;

    emit(state.copyWith(habits: habits));
  }

  void _onCompleteHabit(CompleteHabit event, Emitter<HabitsState> emit) async {
    final state = this.state;
    final habits = state.habits;

    if (!event.habit.canStillComplete) {
      emit(state.copyWith(messageToDisplay: _messageAboutHabitCompletion(event.habit)));
      return;
    }

    final now = DateTime.now();
    final apiException = await _appRepository.completeHabit(event.habit, now);

    if (apiException != null) {
      emit(state.copyWith(messageToDisplay: apiException.message));
      return;
    }

    final newHabit = event.habit.copyWith(doneDates: [...event.habit.doneDates, now]);
    final index = habits.indexWhere((e) => e.uid == event.habit.uid);
    habits[index] = newHabit;

    emit(state.copyWith(messageToDisplay: _messageAboutHabitCompletion(newHabit)));
  }

  void _onSearchSubmitted(SearchSubmitted event, Emitter<HabitsState> emit) {
    _appStatus = AppStatus.searching;
    _title = event.query;
    _sortByDate = event.sortByDate;

    _loadAgain(emit);
  }

  void _onSearchCancelled(SearchCancelled event, Emitter<HabitsState> emit) {
    _appStatus = AppStatus.usual;

    _loadAgain(emit);
  }

  void _loadAgain(Emitter<HabitsState> emit) {
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
