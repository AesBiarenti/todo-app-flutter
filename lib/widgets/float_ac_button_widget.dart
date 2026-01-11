import 'package:basic_todo_app/constants/app_colors.dart';
import 'package:basic_todo_app/core/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloatAcButtonWidget extends ConsumerWidget {
  final void Function(String) addTodo;
  const FloatAcButtonWidget({super.key, required this.addTodo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: AppColors.backgroundDark,
      child: const Icon(Icons.add, color: AppColors.primary, size: 40),
      onPressed: () {
        DialogService.showAddTodoDialog(context, onSave: addTodo);
      },
    );
  }
}
