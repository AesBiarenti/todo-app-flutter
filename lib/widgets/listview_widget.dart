import 'package:basic_todo_app/constants/app_strings.dart';
import 'package:basic_todo_app/model/todo_state.dart';
import 'package:basic_todo_app/providers/todo_provider.dart';
import 'package:basic_todo_app/widgets/todo_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListViewWidget extends ConsumerWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoState = ref.watch(todoStateProvider);
    final todos = ref.watch(filteredProvider);
    final todoNotifier = ref.read(todoStateProvider.notifier);

    if (todoState is TodoLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (todoState is TodoError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
            const SizedBox(height: 16),
            Text(
              todoState.message,
              style: TextStyle(color: Colors.red.shade300),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => todoNotifier.loadTodos(),
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      );
    }
    if (todos.isEmpty) {
      return const Center(child: Text(AppStrings.noTodosYet));
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItemWidget(
          currentTodo: todo,
          index: index,
          onDelete: () => todoNotifier.deleteTodo(todo.id),
          onUpdate: (newName) => todoNotifier.updateTodo(todo.id, newName),
          value: todo.isCompleted,
          onChanged: (value) => todoNotifier.toggledTodo(todo.id),
        );
      },
    );
  }
}
