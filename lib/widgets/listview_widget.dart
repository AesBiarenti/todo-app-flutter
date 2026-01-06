import 'package:basic_todo_app/model/todo_model.dart';
import 'package:flutter/material.dart';

class ListViewWidget extends StatefulWidget {
  final List<TodoModel> todoList;
  const ListViewWidget({super.key, required this.todoList});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

final TextEditingController _textEditingController = TextEditingController();

class _ListViewWidgetState extends State<ListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todoList.length,
      itemBuilder: (context, index) {
        final currentTodo = widget.todoList[index];
        return Dismissible(
          direction: DismissDirection.startToEnd,
          key: GlobalKey(debugLabel: currentTodo.id),
          onDismissed: (direction) {
            deleteTodo(index);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Add Todo"),
                      content: TextField(controller: _textEditingController),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              //* toto ekleme
                              updateTodo(
                                currentTodo.id,
                                _textEditingController,
                              );
                              //* Dialogu Kapatma
                              Navigator.of(context).pop();
                            });
                          },
                          child: Text("Kaydet"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: ListTile(
                leading: Text("$index"),
                title: Text(currentTodo.name),
                subtitle: Text(currentTodo.id),
              ),
            ),
          ),
        );
      },
    );
  }

  void deleteTodo(int index) {
    setState(() {});
    widget.todoList.removeAt(index);
  }

  void updateTodo(String id, TextEditingController textEditingController) {
    setState(() {});
    final index = widget.todoList.indexWhere((t) => t.id == id);
    if (index == -1) return;
    widget.todoList[index] = widget.todoList[index].copyWith(
      name: textEditingController.text.trim(),
    );
    textEditingController.clear();
  }
}
