import 'package:basic_todo_app/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoItemWidget extends ConsumerStatefulWidget {
  final TodoModel currentTodo;
  final int index;
  final VoidCallback onDelete;
  final Function(String) onUpdate;
  const TodoItemWidget({
    super.key,
    required this.currentTodo,
    required this.index,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  ConsumerState<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends ConsumerState<TodoItemWidget> {
  late final TextEditingController _editController;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.currentTodo.name);
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: ValueKey(widget.currentTodo.id),
      onDismissed: (_) => widget.onDelete,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: GestureDetector(
          onTap: () {
            _editController.text = widget.currentTodo.name;
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Add Todo"),
                  content: TextField(controller: _editController),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        final text = _editController.text.trim();
                        if (text.isNotEmpty) {
                          widget.onUpdate(text);
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Kaydet"),
                    ),
                  ],
                );
              },
            );
          },
          child: ListTile(
            leading: Text("${widget.index}"),
            title: Text(widget.currentTodo.name),
            subtitle: Text(widget.currentTodo.id),
          ),
        ),
      ),
    );
  }
}
