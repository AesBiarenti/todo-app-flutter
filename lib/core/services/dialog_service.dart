import 'package:basic_todo_app/constants/app_strings.dart';
import 'package:flutter/material.dart';

/// Dialog işlemlerini yöneten servis
class DialogService {
  static Future<void> showAddTodoDialog(
    BuildContext context, {
    required void Function(String) onSave,
    VoidCallback? onCancel,
  }) {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return _AddTodoDialogWidget(onSave: onSave, onCancel: onCancel);
      },
    );
  }

  static Future<void> showEditTodoDialog(
    BuildContext context, {
    required String initialText,
    required void Function(String) onSave,
    VoidCallback? onCancel,
  }) {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return _EditTodoDialogWidget(
          initialText: initialText,
          onSave: onSave,
          onCancel: onCancel,
        );
      },
    );
  }

  static Future<void> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onCancel?.call();
              },
              child: const Text(AppStrings.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onConfirm();
              },
              child: const Text('Onayla'),
            ),
          ],
        );
      },
    );
  }
}

/// Todo ekleme dialog widget'ı
class _AddTodoDialogWidget extends StatefulWidget {
  final void Function(String) onSave;
  final VoidCallback? onCancel;

  const _AddTodoDialogWidget({required this.onSave, this.onCancel});

  @override
  State<_AddTodoDialogWidget> createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<_AddTodoDialogWidget> {
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
    return AlertDialog(
      title: Text(AppStrings.addTodoTitle),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Todo metnini girin'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onCancel?.call();
          },
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            final text = _controller.text.trim();
            if (text.isNotEmpty) {
              Navigator.of(context).pop();
              widget.onSave(text);
            }
          },
          child: const Text(AppStrings.save),
        ),
      ],
    );
  }
}

/// Todo düzenleme dialog widget'ı
class _EditTodoDialogWidget extends StatefulWidget {
  final String initialText;
  final void Function(String) onSave;
  final VoidCallback? onCancel;

  const _EditTodoDialogWidget({
    required this.initialText,
    required this.onSave,
    this.onCancel,
  });

  @override
  State<_EditTodoDialogWidget> createState() => _EditTodoDialogWidgetState();
}

class _EditTodoDialogWidgetState extends State<_EditTodoDialogWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.editTodoTitle),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Todo metnini düzenleyin'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onCancel?.call();
          },
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            final text = _controller.text.trim();
            if (text.isNotEmpty) {
              Navigator.of(context).pop();
              widget.onSave(text);
            }
          },
          child: const Text(AppStrings.save),
        ),
      ],
    );
  }
}
