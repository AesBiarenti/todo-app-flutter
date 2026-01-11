import 'package:basic_todo_app/constants/enum.dart';
import 'package:basic_todo_app/model/todo_model.dart';
import 'package:basic_todo_app/repository/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:uuid/uuid.dart';

final todoRepositoryProvider = Provider<ITodoRepository>(
  (ref) => TodoRepository(),
);
//*
final filteredTodoList = StateProvider<TodoEnum>((ref) => TodoEnum.all);
//*
final filteredProvider = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(filteredTodoList);
  final todoList = ref.watch(todoProvider);
  switch (filter) {
    case TodoEnum.all:
      return todoList;
    case TodoEnum.active:
      return todoList.where((test) => !test.isCompleted).toList();
    case TodoEnum.completed:
      return todoList.where((test) => test.isCompleted).toList();
  }
});

final todoProvider = StateNotifierProvider<TodoProvider, List<TodoModel>>(
  (ref) => TodoProvider(ref.read(todoRepositoryProvider))..loadTodos(),
);

class TodoProvider extends StateNotifier<List<TodoModel>> {
  TodoProvider(this._repository) : super([]);
  final ITodoRepository _repository;
  final _uuid = Uuid();
  Future<void> loadTodos() async {
    try {
      state = await _repository.getAllTodos();
    } catch (e) {
      debugPrint("Error");
    }
  }

  Future<void> addTodo(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    try {
      final newTodo = TodoModel(
        id: _uuid.v4(),
        name: trimmed,
        isCompleted: false,
      );
      await _repository.addTodo(newTodo);
      state = [...state, newTodo];
    } catch (e) {
      debugPrint('Error adding todo: $e');
      // Hata durumunda kullanıcıya bildirim gösterilebilir
      rethrow;
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _repository.deleteTodo(id);
      state = state.where((t) => t.id != id).toList();
    } catch (e) {
      debugPrint('Error deleting todo: $e');
      rethrow;
    }
  }

  Future<void> updateTodo(String id, String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    try {
      final existingTodo = state.firstWhere((test) => test.id == id);
      final updatedTodo = existingTodo.copyWith(name: trimmed);
      await _repository.updateTodo(updatedTodo);
      state = [
        for (final hedefTodo in state)
          if (hedefTodo.id == id) updatedTodo else hedefTodo,
      ];
    } catch (e) {
      debugPrint('Error updating todo: $e');
      rethrow;
    }
  }

  Future<void> toggledTodo(String id) async {
    try {
      final existingTodo = state.firstWhere((test) => test.id == id);
      final updatedTodo = existingTodo.copyWith(
        isCompleted: !existingTodo.isCompleted,
      );
      await _repository.updateTodo(updatedTodo);
      state = [
        for (final hedefTodo in state)
          if (hedefTodo.id == id) updatedTodo else hedefTodo,
      ];
    } catch (e) {
      debugPrint('Error toggling todo: $e');
      rethrow;
    }
  }
}
