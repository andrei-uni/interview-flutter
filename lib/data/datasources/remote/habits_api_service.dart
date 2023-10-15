import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/add_habit_api.dart';
import 'models/get_habits_api.dart';
import 'models/habit_api.dart';
import 'models/habit_done_api.dart';

part 'habits_api_service.g.dart';

@RestApi()
abstract class HabitsApiService {
  factory HabitsApiService(Dio dio, {String baseUrl}) = _HabitsApiService;

  @POST('/habits')
  Future<HttpResponse<HabitApi>> addHabit(@Body() AddHabitApi addHabitApi);

  @POST('/habits/{id}/complete')
  Future<HttpResponse> completeHabit(@Path() String id, @Body() HabitDoneApi habitDoneApi);

  @DELETE('/habits/{id}')
  Future<HttpResponse> deleteHabit(@Path() String id);

  @PATCH('/habits/{id}')
  Future<HttpResponse> updateHabit(@Path() String id, @Body() AddHabitApi addHabitApi);

  @GET('/habits')
  Future<HttpResponse<GetHabitsApi>> getHabits(
    @Query('offset') int offset,
    @Query('limit') int limit,
    @Query('title') String? title,
    @Query('order_by') String? orderBy,
    @Query('order_direction') String? orderDirection,
  );
}
