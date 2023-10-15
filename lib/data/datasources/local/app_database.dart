import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'daos/habit_dao.dart';
import 'daos/habit_done_dates_dao.dart';
import 'entities/habit_done_dates_entity.dart';
import 'entities/habit_entity.dart';
import 'type_converters/datetime_converter.dart';
import 'type_converters/habit_priority_converter.dart';
import 'type_converters/habit_type_converter.dart';

part 'app_database.g.dart';

@TypeConverters([
  DateTimeConverter,
  HabitPriorityConverter,
  HabitTypeConverter,
])
@Database(version: 1, entities: [
  HabitEntity,
  HabitDoneDatesEntity
])
abstract class AppDatabase extends FloorDatabase {
  HabitDao get habitDao;
  HabitDoneDatesDao get habitDoneDatesDao;
}
