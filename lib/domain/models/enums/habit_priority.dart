enum HabitPriority {
  low,
  medium,
  high;

  String get description {
    return switch (this) {
      HabitPriority.low => "Низкий",
      HabitPriority.medium => "Средний",
      HabitPriority.high => "Высокий",
    };
  }
}
