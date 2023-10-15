part of 'habits_bloc.dart';

@immutable
sealed class HabitsEvent {
  const HabitsEvent();
}

final class GetHabits extends HabitsEvent {}

final class AddNewHabit extends HabitsEvent {
  const AddNewHabit(this.habit);

  final Habit habit;
}

final class EditHabit extends HabitsEvent {
  const EditHabit(this.habit);

  final Habit habit;
}

final class CompleteHabit extends HabitsEvent {
  const CompleteHabit(this.habit);

  final Habit habit;
}

final class SearchSubmitted extends HabitsEvent {
  const SearchSubmitted(this.query, this.sortByDate);

  final String query;
  final SortByDate sortByDate;
}

final class SearchCancelled extends HabitsEvent {
  const SearchCancelled();
}
