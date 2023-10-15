import 'package:floor/floor.dart';

@entity
class HabitDoneDatesEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String uid;
  final DateTime date;

  HabitDoneDatesEntity({
    this.id,
    required this.uid,
    required this.date,
  });
}
