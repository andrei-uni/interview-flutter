enum SortByDate {
  oldest,
  newest;

  String get toApiString {
    return switch (this) {
      SortByDate.newest => "desc",
      SortByDate.oldest => "asc",
    };
  }
}
