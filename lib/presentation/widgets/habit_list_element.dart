import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/habit.dart';
import '../../utils/extensions/dateformat_locale_x.dart';
import '../create_edit_habit/create_edit_habit_page.dart';
import '../habits_bloc/habits_bloc.dart';

class HabitListElement extends StatelessWidget {
  const HabitListElement(this.habit, {super.key});

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Название: ${habit.title}"),
              Text("Описание: ${habit.description}"),
              Text("Приоритет: ${habit.priority.description}"),
              Text("Тип: ${habit.type.description}"),
              Text("Кол-во повторений: ${habit.count}"),
              Text("Период: ${DateFormatLocale.ru.format(habit.completeUntil)}"),
              Text("Создана: ${DateFormatLocale.ru.format(habit.createdAt)}"),
              FilledButton(
                onPressed: () => _completeHabit(context),
                child: const Text("Выполнить"),
              ),
            ],
          ),
        ),
        onTap: () => _editHabit(context),
      ),
    );
  }

  void _completeHabit(BuildContext context) {
    context.read<HabitsBloc>().add(CompleteHabit(habit));
  }

  void _editHabit(BuildContext context) async {
    final editedHabit = await Navigator.of(context).push(
      CreateEditHabitPage.route(habit: habit, pageTitle: "Редактировать"),
    );

    if (editedHabit == null || editedHabit == habit) return;
    if (!context.mounted) return;

    context.read<HabitsBloc>().add(EditHabit(editedHabit));
  }
}
