import '../../domain/models/habit.dart';
import '../datasources/local/entities/habit_done_dates_entity.dart';
import '../datasources/local/entities/habit_entity.dart';
import '../datasources/remote/models/habit_api.dart';

class HabitMapper {
  static Habit fromEntity(HabitEntity habitEntity, List<HabitDoneDatesEntity> habitDoneDatesEntity) {
    return Habit(
      uid: habitEntity.uid,
      title: habitEntity.title,
      description: habitEntity.description,
      priority: habitEntity.priority,
      count: habitEntity.count,
      type: habitEntity.type,
      completeUntil: habitEntity.completeUntil,
      createdAt: habitEntity.createdAt,
      doneDates: habitDoneDatesEntity.map((e) => e.date).toList(),
      color: habitEntity.color,
    );
  }

  static HabitEntity toEntity(Habit habitModel) {
    return HabitEntity(
      uid: habitModel.uid,
      title: habitModel.title,
      description: habitModel.description,
      priority: habitModel.priority,
      count: habitModel.count,
      type: habitModel.type,
      completeUntil: habitModel.completeUntil,
      createdAt: habitModel.createdAt,
      color: habitModel.color,
    );
  }

  static HabitApi toApi(Habit habit) {
    return HabitApi(
      color: habit.color,
      count: habit.count,
      createdAt: habit.createdAt,
      description: habit.description,
      doneDates: habit.doneDates,
      completeUntil: habit.completeUntil,
      priority: habit.priority,
      title: habit.title,
      type: habit.type,
      uid: habit.uid,
    );
  }

  static Habit fromApi(HabitApi habitApi) {
    return Habit(
      uid: habitApi.uid,
      title: habitApi.title,
      description: habitApi.description,
      priority: habitApi.priority,
      count: habitApi.count,
      type: habitApi.type,
      completeUntil: habitApi.completeUntil,
      createdAt: habitApi.createdAt,
      doneDates: habitApi.doneDates?.toList() ?? [],
      color: habitApi.color,
    );
  }
}
