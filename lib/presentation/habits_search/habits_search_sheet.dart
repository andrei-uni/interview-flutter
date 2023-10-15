import 'package:flutter/material.dart';

import 'query_changed.dart';
import 'sort_by_date.dart';

class HabitsSearchSheet extends StatefulWidget {
  const HabitsSearchSheet({
    super.key,
    required this.onQueryChanged,
    required this.onSearchCancelled,
  });

  final QueryChanged onQueryChanged;
  final VoidCallback onSearchCancelled;

  @override
  State<HabitsSearchSheet> createState() => _HabitsSearchSheetState();
}

class _HabitsSearchSheetState extends State<HabitsSearchSheet> {
  final queryController = TextEditingController();
  var sortByDate = SortByDate.newest;

  @override
  void dispose() {
    widget.onSearchCancelled();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: Column(
            children: [
              _searchField(),
              const SizedBox(height: 10),
              _dateSelector(),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _searchSubmitted,
                  child: const Text("Найти"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _searchField() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: queryController,
            decoration: const InputDecoration(
              hintText: 'Найти привычку',
            ),
            autofocus: true,
            onSubmitted: (value) => _searchSubmitted(),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              if (queryController.text.isEmpty) Navigator.of(context).pop();
              setState(() {
                queryController.text = "";
              });
            },
            icon: const Icon(Icons.close),
          ),
        ),
      ],
    );
  }

  Widget _dateSelector() {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton(
        segments: const [
          ButtonSegment(value: SortByDate.newest, label: Text("Сначала новые")),
          ButtonSegment(value: SortByDate.oldest, label: Text("Сначала старые")),
        ],
        selected: {sortByDate},
        onSelectionChanged: (value) => setState(() => sortByDate = value.first),
      ),
    );
  }

  void _searchSubmitted() {
    widget.onQueryChanged(queryController.text, sortByDate);
  }
}
