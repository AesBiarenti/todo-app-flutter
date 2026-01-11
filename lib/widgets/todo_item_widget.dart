import 'package:basic_todo_app/constants/app_colors.dart';
import 'package:basic_todo_app/core/services/dialog_service.dart';
import 'package:basic_todo_app/model/todo_model.dart';
import 'package:basic_todo_app/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoItemWidget extends ConsumerStatefulWidget {
  final TodoModel currentTodo;
  final int index;
  final VoidCallback onDelete;
  final void Function(String) onUpdate;
  final bool value;
  final void Function(bool) onChanged;
  const TodoItemWidget({
    super.key,
    required this.currentTodo,
    required this.index,
    required this.onDelete,
    required this.onUpdate,
    required this.value,
    required this.onChanged,
  });

  @override
  ConsumerState<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends ConsumerState<TodoItemWidget> {
  @override
  Widget build(BuildContext context) {
    final asyncNotifier = ref.read(asyncTodoStateProvider.notifier);
    final todoNotifier = ref.read(todoStateProvider.notifier);

    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: ValueKey(widget.currentTodo.id),
      confirmDismiss: (direction) async {
        // Silme işlemini önce yap, başarılı olursa dismiss et
        asyncNotifier.setLoading();
        try {
          await todoNotifier.deleteTodo(widget.currentTodo.id);
          asyncNotifier.setSuccess();
          return true; // Dismiss onaylandı
        } catch (e) {
          asyncNotifier.setError('Todo silinirken bir hata oluştu');
          return false; // Dismiss iptal edildi
        }
      },
      onDismissed: (_) {
        // onDismissed sadece dismiss onaylandığında çağrılır
        // Burada ek işlem yapmaya gerek yok
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.getTodoItemBackground(widget.value),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: GestureDetector(
          onTap: () {
            DialogService.showEditTodoDialog(
              context,
              initialText: widget.currentTodo.name,
              onSave: (text) async {
                asyncNotifier.setLoading();
                try {
                  await todoNotifier.updateTodo(widget.currentTodo.id, text);
                  asyncNotifier.setSuccess();
                } catch (e) {
                  asyncNotifier.setError('Todo güncellenirken bir hata oluştu');
                }
              },
            );
          },
          child: ListTile(
            leading: Text("${widget.index}"),
            title: Text(
              widget.currentTodo.name,
              style: TextStyle(
                decoration: widget.value ? TextDecoration.lineThrough : null,
                color: AppColors.getTodoItemTextColor(widget.value),
              ),
            ),
            subtitle: Text(widget.currentTodo.id),
            trailing: Checkbox(
              value: widget.value,
              onChanged: (value) async {
                asyncNotifier.setLoading();
                try {
                  await todoNotifier.toggledTodo(widget.currentTodo.id);
                  asyncNotifier.setSuccess();
                } catch (e) {
                  asyncNotifier.setError(
                    'Todo durumu değiştirilirken bir hata oluştu',
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
