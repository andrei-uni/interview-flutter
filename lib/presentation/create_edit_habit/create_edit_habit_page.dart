import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/enums/habit_priority.dart';
import '../../domain/models/enums/habit_type.dart';
import '../../domain/models/habit.dart';
import '../../utils/extensions/dateformat_locale_x.dart';
import '../widgets/radio_button_selection.dart';
import 'create_edit_habit_bloc/create_edit_habit_bloc.dart';

class CreateEditHabitPage extends StatefulWidget {
  const CreateEditHabitPage({
    super.key,
    required this.habit,
    required this.pageTitle,
  });

  final Habit? habit;
  final String pageTitle;

  static Route<Habit?> route({required Habit? habit, required String pageTitle}) {
    return MaterialPageRoute(
      builder: (_) => CreateEditHabitPage(habit: habit, pageTitle: pageTitle),
    );
  }

  @override
  State<CreateEditHabitPage> createState() => _CreateEditHabitPageState();
}

class _CreateEditHabitPageState extends State<CreateEditHabitPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditHabitBloc(widget.habit),
      child: _CreateEditHabitView(pageTitle: widget.pageTitle),
    );
  }
}

class _CreateEditHabitView extends StatefulWidget {
  const _CreateEditHabitView({required this.pageTitle});

  final String pageTitle;

  @override
  State<_CreateEditHabitView> createState() => _CreateEditHabitViewState();
}

class _CreateEditHabitViewState extends State<_CreateEditHabitView> {
  @override
  Widget build(BuildContext context) {
    const spaceBetweenInputs = 30.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
        actions: [
          BlocBuilder<CreateEditHabitBloc, CreateEditHabitState>(
            builder: (context, state) {
              return IconButton(
                onPressed: state.isValid
                    ? () {
                        final newHabit = context.read<CreateEditHabitBloc>().getNewHabit();
                        Navigator.of(context).pop(newHabit);
                      }
                    : null,
                icon: const Icon(Icons.check),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _titleInput(),
              const SizedBox(height: spaceBetweenInputs),
              _descriptionInput(),
              const SizedBox(height: spaceBetweenInputs),
              _prioritySelector(),
              const SizedBox(height: spaceBetweenInputs),
              _typeSelector(),
              const SizedBox(height: spaceBetweenInputs),
              _countInput(),
              const SizedBox(height: spaceBetweenInputs),
              _completeUntilPicker(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleInput() {
    return BlocBuilder<CreateEditHabitBloc, CreateEditHabitState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: 'Название',
            errorText: state.title.displayError?.errorMessage,
          ),
          textCapitalization: TextCapitalization.sentences,
          onChanged: (value) => context.read<CreateEditHabitBloc>().add(TitleChanged(value)),
          initialValue: state.title.value,
        );
      },
    );
  }

  Widget _descriptionInput() {
    return BlocBuilder<CreateEditHabitBloc, CreateEditHabitState>(
      buildWhen: (previous, current) => previous.description != current.description,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Описание',
            errorText: state.description.displayError?.errorMessage,
          ),
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.multiline,
          maxLines: 2,
          onChanged: (value) => context.read<CreateEditHabitBloc>().add(DescriptionChanged(value)),
          initialValue: state.description.value,
        );
      },
    );
  }

  Widget _prioritySelector() {
    return BlocBuilder<CreateEditHabitBloc, CreateEditHabitState>(
      buildWhen: (previous, current) => previous.habitPriority != current.habitPriority,
      builder: (context, state) {
        return DropdownButtonFormField(
          decoration: const InputDecoration(labelText: 'Приоритет'),
          items: HabitPriority.values.map((v) => DropdownMenuItem(value: v, child: Text(v.description))).toList(),
          value: state.habitPriority,
          onChanged: (value) => context.read<CreateEditHabitBloc>().add(PriorityChanged(value!)),
        );
      },
    );
  }

  Widget _typeSelector() {
    return BlocBuilder<CreateEditHabitBloc, CreateEditHabitState>(
      buildWhen: (previous, current) => previous.habitType != current.habitType,
      builder: (context, state) {
        return RadioButtonSelection(
          label: Text("Тип", style: Theme.of(context).textTheme.titleMedium),
          items: HabitType.values.map((v) => RadioButtonSelectionItem(value: v, child: Text(v.description))).toList(),
          groupValue: state.habitType,
          onChanged: (value) => context.read<CreateEditHabitBloc>().add(TypeChanged(value)),
        );
      },
    );
  }

  Widget _countInput() {
    return BlocBuilder<CreateEditHabitBloc, CreateEditHabitState>(
      buildWhen: (previous, current) => previous.count != current.count,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: "Количество повторений",
            errorText: state.count.displayError?.errorMessage,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) => context.read<CreateEditHabitBloc>().add(CountChanged(value)),
          initialValue: state.count.value,
        );
      },
    );
  }

  Widget _completeUntilPicker(BuildContext context) {
    return BlocBuilder<CreateEditHabitBloc, CreateEditHabitState>(
      buildWhen: (previous, current) => previous.completeUntil != current.completeUntil,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Дата окончания", style: Theme.of(context).textTheme.titleMedium),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  await _showDateTimePicker(context: context, initialDate: state.completeUntil);
                },
                child: Text(DateFormatLocale.ru.format(state.completeUntil)),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDateTimePicker({required BuildContext context, required DateTime initialDate}) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate == null) return;
    if (!context.mounted) return;

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    final completeDate = selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );

    if (context.mounted) context.read<CreateEditHabitBloc>().add(CompleteUntilChanged(completeDate));
  }
}
