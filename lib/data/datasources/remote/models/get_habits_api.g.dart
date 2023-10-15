// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_habits_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHabitsApi _$GetHabitsApiFromJson(Map<String, dynamic> json) => GetHabitsApi(
      count: json['count'] as int,
      habits: (json['habits'] as List<dynamic>?)
          ?.map((e) => HabitApi.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetHabitsApiToJson(GetHabitsApi instance) =>
    <String, dynamic>{
      'count': instance.count,
      'habits': instance.habits,
    };
