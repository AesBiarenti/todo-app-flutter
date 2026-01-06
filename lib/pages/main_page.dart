import 'package:basic_todo_app/model/todo_model.dart';
import 'package:basic_todo_app/widgets/float_ac_button_widget.dart';
import 'package:basic_todo_app/widgets/listview_widget.dart';
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
      floatingActionButton: FloatAcButtonWidget(
        textEditingController: _textEditingController,
        addTodo: () {
          addTodo(_textEditingController);
          Navigator.of(context).pop();
        },
      ),
      body: ListViewWidget(todoList: _todoList),
    );
  }

  void addTodo(TextEditingController textEditingController) {
    setState(() {});
    _todoList.add(TodoModel(Uuid().v4(), name: textEditingController.text));
    textEditingController.clear();
    debugPrint("Eklenen veri ile birlikte todo :$_todoList");
  }
}
