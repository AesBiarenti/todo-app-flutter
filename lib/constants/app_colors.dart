import 'package:basic_todo_app/constants/enum.dart';
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color primary = Colors.deepPurple;
  static const Color secondary = Colors.grey;

  static const Color backgroundDark = Color(
    0xFF121212,
  ); // grey.shade900 equivalent
  static const Color backgroundLight = Colors.grey;

  static const Color textPrimary = Colors.deepPurple;
  static const Color textSecondary = Colors.grey;
  static Color textDisabled = Colors.grey.shade300;

  static Color getFilterActiveBackground(
    TodoEnum filter,
    TodoEnum currentFilter,
  ) {
    return filter == currentFilter ? primary : secondary;
  }

  static Color getFilterActiveText(TodoEnum filter, TodoEnum currentFilter) {
    return filter == currentFilter ? textSecondary : textPrimary;
  }

  // Todo Item Colors
  static Color getTodoItemBackground(bool isCompleted) {
    return isCompleted ? secondary : primary;
  }

  static Color? getTodoItemTextColor(bool isCompleted) {
    return isCompleted ? textDisabled : null;
  }
}


