import 'package:basic_todo_app/providers/todo_provider.dart';
import 'package:basic_todo_app/widgets/float_ac_button_widget.dart';
import 'package:basic_todo_app/widgets/listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatAcButtonWidget(
        addTodo: (text) {
         ref.read(todoProvider.notifier).addTodo(text);
        },
      ),
      body: ListViewWidget(),
    );
  }
}

