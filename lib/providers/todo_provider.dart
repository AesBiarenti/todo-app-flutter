import 'package:basic_todo_app/model/todo_model.dart';
import 'package:basic_todo_app/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:uuid/uuid.dart';

final todoProvider = StateNotifierProvider<TodoProvider, List<TodoModel>>(
  (ref) => TodoProvider()..loadTodos(),
);

class TodoProvider extends StateNotifier<List<TodoModel>> {
  TodoProvider() : super([]);
  final _uuid = Uuid();

  Future<void> loadTodos() async {
    state = HiveService.getAllTodos();
  }

  Future<void> addTodo(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    final newTodo = TodoModel(id: _uuid.v4(), name: name);
    await HiveService.addTodo(newTodo);
    state = [...state, newTodo];
    debugPrint(state.length.toString());
  }

  Future<void> deleteTodo(String id) async {
    await HiveService.deleteTodo(id);
    state = state.where((t) => t.id != id).toList();
  }

  Future<void> updateTodo(String id, String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    final updatedTodo = TodoModel(id: id, name: trimmed);
    await HiveService.updateTodo(updatedTodo);
    state = [
      for (final hedefTodo in state)
        if (hedefTodo.id == id) hedefTodo.copyWith(name: name) else hedefTodo,
    ];
  }
}
