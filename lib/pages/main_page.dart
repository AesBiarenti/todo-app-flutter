import 'package:basic_todo_app/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

List<TodoModel> _todoList = [];
final TextEditingController _textEditingController = TextEditingController();

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade900,
        child: Icon(Icons.add, color: Colors.deepPurple, size: 40),
        onPressed: () {
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
                        addTodo(_textEditingController);
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
      ),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          final currentTodo = _todoList[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            color: Colors.deepPurple,
            child: ListTile(
              leading: Text("$index"),
              title: Text(currentTodo.name),
              subtitle: Text(currentTodo.id),
            ),
          );
        },
      ),
    );
  }
}

void addTodo(TextEditingController textEditingController) {
  _todoList.add(TodoModel(id: Uuid().v4(), name: textEditingController.text));
  debugPrint("Eklenen veri ile birlikte todo :$_todoList");
}
