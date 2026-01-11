import 'package:basic_todo_app/model/todo_model.dart';

/// Todo işlemlerinin durumunu temsil eden sınıf
sealed class TodoState {
  const TodoState();
}

/// Başlangıç durumu
class TodoInitial extends TodoState {
  const TodoInitial();
}

/// Yükleme durumu
class TodoLoading extends TodoState {
  const TodoLoading();
}

/// Başarılı durum - todo listesi ile
class TodoLoaded extends TodoState {
  final List<TodoModel> todos;
  const TodoLoaded(this.todos);
}

/// Hata durumu
class TodoError extends TodoState {
  final String message;
  const TodoError(this.message);
}

/// Asenkron CRUD işlemleri için state sınıfları
sealed class AsyncTodoState {
  const AsyncTodoState();
}

/// Async işlem boşta durumu
class AsyncTodoIdle extends AsyncTodoState {
  const AsyncTodoIdle();
}

/// Async işlem yükleniyor durumu
class AsyncTodoLoading extends AsyncTodoState {
  const AsyncTodoLoading();
}

/// Async işlem başarılı durumu
class AsyncTodoSuccess extends AsyncTodoState {
  const AsyncTodoSuccess();
}

/// Async işlem hata durumu
class AsyncTodoError extends AsyncTodoState {
  final String message;
  const AsyncTodoError(this.message);
}
