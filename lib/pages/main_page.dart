import 'package:basic_todo_app/providers/todo_provider.dart';
import 'package:basic_todo_app/widgets/float_ac_button_widget.dart';
import 'package:basic_todo_app/widgets/listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

final TextEditingController _textEditingController = TextEditingController();

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatAcButtonWidget(
        textEditingController: _textEditingController,
        addTodo: () {
          ref.read(todoProvider.notifier).addTodo(_textEditingController.text);
          _textEditingController.clear();
          Navigator.of(context).pop();
        },
      ),
      body: ListViewWidget(),
    );
  }
}
