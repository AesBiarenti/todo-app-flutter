class AppStrings {
  AppStrings._(); // Private constructor to prevent instantiation

  // Filter Labels
  static const String filterAll = "Hepsi";
  static const String filterCompleted = "Tamamlanmış";
  static const String filterActive = "Tamamlanmamış";

  // Dialog Titles
  static const String addTodoTitle = "Todo";
  static const String editTodoTitle = "Add Todo";

  // Buttons
  static const String save = "Kaydet";
  static const String cancel = "İptal";

  // Messages
  static const String noTodosYet = "Henüz todo yok";

  // Errors
  static const String hiveNotInitialized =
      "HiveServices henüz initilize edilmemiş";
  static const String hiveInitializationError =
      "Hive services initilized hatası";
}
