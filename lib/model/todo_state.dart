import 'package:basic_todo_app/model/todo_model.dart';

sealed class TodoState {
  const TodoState();
}

class TodoInitial extends TodoState {
  const TodoInitial();
}

class TodoLoading extends TodoState {
  const TodoLoading();
}

class TodoLoaded extends TodoState {
  final List<TodoModel> todos;
  const TodoLoaded(this.todos);
}

class TodoError extends TodoState {
  final String message;
  const TodoError(this.message);
}

//* Asenkron crud işlemleri için bunlar.
sealed class AsyncTodoState {
  const AsyncTodoState();
}

class AsyncTodoIdle extends AsyncTodoState {
  const AsyncTodoIdle();
}

class AsyncTodoLoading extends AsyncTodoState {
  const AsyncTodoLoading();
}

class AsyncTodoSuccess extends AsyncTodoState {
  const AsyncTodoSuccess();
}

class AsyncTodoError extends AsyncTodoState {
  final String message;
  const AsyncTodoError(this.message);
}
