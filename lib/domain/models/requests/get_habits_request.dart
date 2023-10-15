final class GetHabitsRequest {
  final int offset;
  final int limit;
  final String? title;
  final String? orderBy;
  final String? orderDirection;

  GetHabitsRequest({
    required this.offset,
    required this.limit,
    this.title,
    this.orderBy,
    this.orderDirection,
  });
}
