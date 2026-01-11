import 'package:basic_todo_app/constants/enum.dart';
import 'package:basic_todo_app/core/models/todo_state.dart';
import 'package:basic_todo_app/model/todo_model.dart';

import 'package:basic_todo_app/repository/todo_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:uuid/uuid.dart';

final todoRepositoryProvider = Provider<ITodoRepository>(
  (ref) => TodoRepository(),
);

final filteredTodoList = StateProvider<TodoEnum>((ref) => TodoEnum.all);

final filteredProvider = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(filteredTodoList);
  final todoState = ref.watch(todoStateProvider);

  if (todoState is TodoLoaded) {
    final todoList = todoState.todos;
    switch (filter) {
      case TodoEnum.all:
        return todoList;
      case TodoEnum.active:
        return todoList.where((test) => !test.isCompleted).toList();
      case TodoEnum.completed:
        return todoList.where((test) => test.isCompleted).toList();
    }
  }
  return [];
});

// Ana state provider
final todoStateProvider = StateNotifierProvider<TodoStateNotifier, TodoState>(
  (ref) => TodoStateNotifier(ref.read(todoRepositoryProvider))..loadTodos(),
);

// Async işlemler için provider
final asyncTodoStateProvider =
    StateNotifierProvider<AsyncTodoStateNotifier, AsyncTodoState>(
      (ref) => AsyncTodoStateNotifier(),
    );

// Eski provider - geriye dönük uyumluluk için
final todoProvider = Provider<List<TodoModel>>((ref) {
  final state = ref.watch(todoStateProvider);
  if (state is TodoLoaded) {
    return state.todos;
  }
  return [];
});

class TodoStateNotifier extends StateNotifier<TodoState> {
  TodoStateNotifier(this._repository) : super(const TodoInitial());

  final ITodoRepository _repository;

  Future<void> loadTodos() async {
    state = const TodoLoading();
    try {
      final todos = await _repository.getAllTodos();
      state = TodoLoaded(todos);
    } catch (e) {
      state = TodoError(
        'Todo\'lar yüklenirken bir hata oluştu: ${e.toString()}',
      );
    }
  }

  Future<void> addTodo(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    if (state is! TodoLoaded) return;

    final currentTodos = (state as TodoLoaded).todos;

    try {
      final newTodo = TodoModel(
        id: const Uuid().v4(),
        name: trimmed,
        isCompleted: false,
      );
      await _repository.addTodo(newTodo);
      state = TodoLoaded([...currentTodos, newTodo]);
    } catch (e) {
      state = TodoError('Todo eklenirken bir hata oluştu: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> deleteTodo(String id) async {
    if (state is! TodoLoaded) return;

    final currentTodos = (state as TodoLoaded).todos;

    try {
      await _repository.deleteTodo(id);
      state = TodoLoaded(currentTodos.where((t) => t.id != id).toList());
    } catch (e) {
      state = TodoError('Todo silinirken bir hata oluştu: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> updateTodo(String id, String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    if (state is! TodoLoaded) return;

    final currentTodos = (state as TodoLoaded).todos;

    try {
      final existingTodo = currentTodos.firstWhere((test) => test.id == id);
      final updatedTodo = existingTodo.copyWith(name: trimmed);
      await _repository.updateTodo(updatedTodo);
      state = TodoLoaded([
        for (final hedefTodo in currentTodos)
          if (hedefTodo.id == id) updatedTodo else hedefTodo,
      ]);
    } catch (e) {
      state = TodoError('Todo güncellenirken bir hata oluştu: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> toggledTodo(String id) async {
    if (state is! TodoLoaded) return;

    final currentTodos = (state as TodoLoaded).todos;

    try {
      final existingTodo = currentTodos.firstWhere((test) => test.id == id);
      final updatedTodo = existingTodo.copyWith(
        isCompleted: !existingTodo.isCompleted,
      );
      await _repository.updateTodo(updatedTodo);
      state = TodoLoaded([
        for (final hedefTodo in currentTodos)
          if (hedefTodo.id == id) updatedTodo else hedefTodo,
      ]);
    } catch (e) {
      state = TodoError(
        'Todo durumu değiştirilirken bir hata oluştu: ${e.toString()}',
      );
      rethrow;
    }
  }
}

class AsyncTodoStateNotifier extends StateNotifier<AsyncTodoState> {
  AsyncTodoStateNotifier() : super(const AsyncTodoIdle());

  void setLoading() {
    state = const AsyncTodoLoading();
  }

  void setSuccess() {
    state = const AsyncTodoSuccess();
    // Kısa süre sonra idle'a dön
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        state = const AsyncTodoIdle();
      }
    });
  }

  void setError(String message) {
    state = AsyncTodoError(message);
    // Kısa süre sonra idle'a dön
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        state = const AsyncTodoIdle();
      }
    });
  }

  void reset() {
    state = const AsyncTodoIdle();
  }
}
