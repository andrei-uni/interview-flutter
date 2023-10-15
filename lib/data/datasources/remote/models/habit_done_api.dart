import 'package:json_annotation/json_annotation.dart';

import '../json_converters/datetime_converter.dart';

part 'habit_done_api.g.dart';

@JsonSerializable()
@DateTimeConverter()
class HabitDoneApi {
  final DateTime date;

  HabitDoneApi({
    required this.date
  });

  factory HabitDoneApi.fromJson(Map<String, dynamic> json) => _$HabitDoneApiFromJson(json);

  Map<String, dynamic> toJson() => _$HabitDoneApiToJson(this);
}
