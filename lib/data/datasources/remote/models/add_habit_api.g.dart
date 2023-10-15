// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_habit_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddHabitApi _$AddHabitApiFromJson(Map<String, dynamic> json) => AddHabitApi(
      color: json['color'] as int,
      count: json['count'] as int,
      createdAt: const DateTimeConverter().fromJson(json['date'] as int),
      description: json['description'] as String,
      completeUntil:
          const DateTimeConverter().fromJson(json['frequency'] as int),
      priority:
          const HabitPriorityConverter().fromJson(json['priority'] as int),
      title: json['title'] as String,
      type: const HabitTypeConverter().fromJson(json['type'] as int),
    );

Map<String, dynamic> _$AddHabitApiToJson(AddHabitApi instance) =>
    <String, dynamic>{
      'color': instance.color,
      'count': instance.count,
      'date': const DateTimeConverter().toJson(instance.createdAt),
      'description': instance.description,
      'frequency': const DateTimeConverter().toJson(instance.completeUntil),
      'priority': const HabitPriorityConverter().toJson(instance.priority),
      'title': instance.title,
      'type': const HabitTypeConverter().toJson(instance.type),
    };
