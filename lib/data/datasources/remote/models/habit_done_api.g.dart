// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_done_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitDoneApi _$HabitDoneApiFromJson(Map<String, dynamic> json) => HabitDoneApi(
      date: const DateTimeConverter().fromJson(json['date'] as int),
    );

Map<String, dynamic> _$HabitDoneApiToJson(HabitDoneApi instance) =>
    <String, dynamic>{
      'date': const DateTimeConverter().toJson(instance.date),
    };
