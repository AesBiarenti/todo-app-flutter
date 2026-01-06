import 'package:basic_todo_app/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:uuid/uuid.dart';

final todoProvider = StateNotifierProvider<TodoProvider, List<TodoModel>>(
  (ref) => TodoProvider(),
);

class TodoProvider extends StateNotifier<List<TodoModel>> {
  TodoProvider() : super([]);
  final _uuid = Uuid();
  void addTodo(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    state = [...state, TodoModel(_uuid.v4(), name: trimmed)];
    debugPrint(state.length.toString());
  }

  void deleteTodo(String id) {
    state = state.where((t) => t.id != id).toList();
  }

  void updateTodo(String id, String name) {
    state = [
      for (final hedefTodo in state)
        if (hedefTodo.id == id) hedefTodo.copyWith(name: name) else hedefTodo,
    ];
  }
}
