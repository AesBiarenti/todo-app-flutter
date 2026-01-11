import 'package:basic_todo_app/model/todo_model.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  static const String _todoModelBox = "todomodelbox";
  static bool _isInitialized = false;
  static Box<TodoModel>? _box;

  static Box<TodoModel> get box {
    if (_box == null || !_box!.isOpen) {
      throw Exception("HiveServices henüz initilize edilmemiş");
    }
    return _box!;
  }

  static bool get isInitialized => _isInitialized;

  static Future<void> init() async {
    if (_isInitialized) return;
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(TodoModelAdapter());
      _box = await Hive.openBox<TodoModel>(_todoModelBox);
      _isInitialized = true;
    } catch (e) {
      throw Exception("Hive services initilized hatası + $e");
    }
  }

  //* Yampak zorunda değiliz opsiyoneldir uygulamayı kapatırken çalıştırız.
  static Future<void> close() async {
    if (_box != null && _box!.isOpen) {
      await _box!.close();
      _isInitialized = false;
    }
  }

  static List<TodoModel> getAllTodos() {
    return _box?.values.toList() ?? [];
  }

  static Future<void> addTodo(TodoModel todo) async {
    await _box?.put(todo.id, todo);
  }

  static Future<void> deleteTodo(String id) async {
    await _box?.delete(id);
  }

  static Future<void> updateTodo(TodoModel todo) async {
    await _box?.put(todo.id, todo);
  }

  static Future<void> clearAllTodos() async {
    await _box?.clear();
  }

  static TodoModel? getTodo(String id) {
    return _box?.get(id);
  }
}
