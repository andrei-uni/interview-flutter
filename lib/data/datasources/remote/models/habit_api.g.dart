// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitApi _$HabitApiFromJson(Map<String, dynamic> json) => HabitApi(
      color: json['color'] as int,
      count: json['count'] as int,
      createdAt: const DateTimeConverter().fromJson(json['date'] as int),
      description: json['description'] as String,
      doneDates: (json['done_dates'] as List<dynamic>?)
          ?.map((e) => const DateTimeConverter().fromJson(e as int))
          .toList(),
      completeUntil:
          const DateTimeConverter().fromJson(json['frequency'] as int),
      priority:
          const HabitPriorityConverter().fromJson(json['priority'] as int),
      title: json['title'] as String,
      type: const HabitTypeConverter().fromJson(json['type'] as int),
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$HabitApiToJson(HabitApi instance) => <String, dynamic>{
      'color': instance.color,
      'count': instance.count,
      'date': const DateTimeConverter().toJson(instance.createdAt),
      'description': instance.description,
      'done_dates':
          instance.doneDates?.map(const DateTimeConverter().toJson).toList(),
      'frequency': const DateTimeConverter().toJson(instance.completeUntil),
      'priority': const HabitPriorityConverter().toJson(instance.priority),
      'title': instance.title,
      'type': const HabitTypeConverter().toJson(instance.type),
      'uid': instance.uid,
    };
