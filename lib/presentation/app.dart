import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/utils/extensions/habits_filter_x.dart';

import '../domain/models/enums/habit_type.dart';
import 'create_edit_habit/create_edit_habit_page.dart';
import 'habits_bloc/habits_bloc.dart';
import 'habits_search/habits_search_sheet.dart';
import 'widgets/habits_list_view.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Трекер привычек'),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Все"),
              Tab(text: "Хорошие"),
              Tab(text: "Плохие"),
            ],
          ),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                onPressed: () => _searchPressed(context),
                icon: const Icon(Icons.search),
              );
            }),
          ],
        ),
        body: Stack(
          children: [
            BlocConsumer<HabitsBloc, HabitsState>(
              listenWhen: (previous, current) => current.messageToDisplay != null,
              listener: (context, state) => _showSnackbar(context, state.messageToDisplay!),
              builder: (context, state) {
                return TabBarView(
                  children: [
                    HabitsListView(
                      state.habits,
                      onBottomReached: () => context.read<HabitsBloc>().add(GetHabits()),
                      hasReachedMax: state.hasReachedMax,
                      habitsStatus: state.status,
                    ),
                    HabitsListView(state.habits.filterByType(HabitType.good)),
                    HabitsListView(state.habits.filterByType(HabitType.bad)),
                  ],
                );
              },
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: FloatingActionButton(
                tooltip: "Добавить новую привычку",
                onPressed: () => _createNewHabit(context),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searchPressed(BuildContext context) async {
    cancelled() => context.read<HabitsBloc>().add(const SearchCancelled());
    showBottomSheet(
      context: context,
      builder: (context) => BlocBuilder<HabitsBloc, HabitsState>(
        builder: (context, state) {
          return HabitsSearchSheet(
            onQueryChanged: (query, sortByDate) {
              context.read<HabitsBloc>().add(SearchSubmitted(query, sortByDate));
            },
            onSearchCancelled: cancelled,
          );
        },
      ),
    );
  }

  void _createNewHabit(BuildContext context) async {
    final habit = await Navigator.of(context).push(
      CreateEditHabitPage.route(habit: null, pageTitle: "Новая привычка"),
    );

    if (habit == null) return;
    if (!context.mounted) return;

    context.read<HabitsBloc>().add(AddNewHabit(habit));
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
