import 'package:basic_todo_app/model/todo_model.dart';
import 'package:basic_todo_app/services/hive_service.dart';

/// Todo verilerini yöneten repository interface'i
abstract class ITodoRepository {
  Future<List<TodoModel>> getAllTodos();
  Future<void> addTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
  Future<void> updateTodo(TodoModel todo);
  Future<void> clearAllTodos();
  Future<TodoModel?> getTodo(String id);
}

/// Hive kullanarak todo verilerini yöneten repository implementasyonu
class TodoRepository implements ITodoRepository {
  @override
  Future<List<TodoModel>> getAllTodos() async {
    try {
      return HiveService.getAllTodos();
    } catch (e) {
      throw Exception('Failed to get all todos: $e');
    }
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    try {
      await HiveService.addTodo(todo);
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      await HiveService.deleteTodo(id);
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    try {
      await HiveService.updateTodo(todo);
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  @override
  Future<void> clearAllTodos() async {
    try {
      await HiveService.clearAllTodos();
    } catch (e) {
      throw Exception('Failed to clear all todos: $e');
    }
  }

  @override
  Future<TodoModel?> getTodo(String id) async {
    try {
      return HiveService.getTodo(id);
    } catch (e) {
      throw Exception('Failed to get todo: $e');
    }
  }
}
