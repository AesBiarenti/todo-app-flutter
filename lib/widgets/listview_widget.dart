import 'package:basic_todo_app/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListViewWidget extends ConsumerStatefulWidget {
  const ListViewWidget({super.key});

  @override
  ConsumerState<ListViewWidget> createState() => _ListViewWidgetState();
}

final TextEditingController _textEditingController = TextEditingController();

class _ListViewWidgetState extends ConsumerState<ListViewWidget> {
  @override
  Widget build(BuildContext context) {
    final todoProviderList = ref.watch(todoProvider);
    final todoProviderUD = ref.read(todoProvider.notifier);
    return ListView.builder(
      itemCount: todoProviderList.length,
      itemBuilder: (context, index) {
        final currentTodo = todoProviderList[index];
        return Dismissible(
          direction: DismissDirection.startToEnd,
          key: ValueKey(currentTodo.id),
          onDismissed: (_) {
            todoProviderUD.deleteTodo(currentTodo.id);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: GestureDetector(
              onTap: () {
                _textEditingController.text = currentTodo.name;
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
                              todoProviderUD.updateTodo(
                                currentTodo.id,
                                _textEditingController.text,
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
}
