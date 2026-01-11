import 'package:basic_todo_app/providers/todo_provider.dart';
import 'package:basic_todo_app/widgets/todo_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListViewWidget extends ConsumerWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final todoNotifier = ref.read(todoProvider.notifier);

    if (todos.isEmpty) {
      return const Center(child: Text("Henüz todo yok"));
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
