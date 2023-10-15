import 'package:flutter/material.dart';

import '../../domain/models/habit.dart';
import '../habits_bloc/habits_bloc.dart';
import 'habit_list_element.dart';

class HabitsListView extends StatefulWidget {
  const HabitsListView(
    this.habits, {
    this.onBottomReached,
    this.hasReachedMax = true,
    this.habitsStatus = HabitsStatus.loaded,
    super.key,
  });

  final List<Habit> habits;
  final VoidCallback? onBottomReached;
  final bool hasReachedMax;
  final HabitsStatus habitsStatus;

  @override
  State<HabitsListView> createState() => _HabitsListViewState();
}

class _HabitsListViewState extends State<HabitsListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.habitsStatus) {
      HabitsStatus.loading => () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }(),
      HabitsStatus.loaded => () {
          if (widget.habits.isEmpty) {
            return const Center(
              child: Text("Ничего не нашли :("),
            );
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: widget.habits.length + (widget.hasReachedMax ? 0 : 1),
            itemBuilder: (context, index) {
              if (index >= widget.habits.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: SizedBox.square(
                      dimension: 25,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.only(
                  right: 10,
                  left: 10,
                  top: 5,
                  bottom: index == widget.habits.length ? 200 : 5,
                ),
                child: HabitListElement(widget.habits[index]),
              );
            },
          );
        }(),
    };
  }

  void _onScroll() {
    if (_isBottom && !widget.hasReachedMax) widget.onBottomReached?.call();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
