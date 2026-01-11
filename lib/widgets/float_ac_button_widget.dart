import 'package:basic_todo_app/constants/app_colors.dart';
import 'package:basic_todo_app/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloatAcButtonWidget extends ConsumerStatefulWidget {
  final Function(String) addTodo;
  const FloatAcButtonWidget({super.key, required this.addTodo});

  @override
  ConsumerState<FloatAcButtonWidget> createState() =>
      _FloatAcButtonWidgetState();
}

class _FloatAcButtonWidgetState extends ConsumerState<FloatAcButtonWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: AppColors.backgroundDark,
      child: Icon(Icons.add, color: AppColors.primary, size: 40),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(AppStrings.addTodoTitle),
              content: TextField(controller: _controller, autofocus: true),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(AppStrings.cancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      widget.addTodo(text);
                      _controller.clear();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(AppStrings.save),
                ),
              ],
            );
          },
        );
      },
    );
  }
}