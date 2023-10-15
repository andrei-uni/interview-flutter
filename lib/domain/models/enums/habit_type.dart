enum HabitType {
  good,
  bad;

  String get description {
    return switch (this) {
      HabitType.good => "Хорошая",
      HabitType.bad => "Плохая",
    };
  }
}
