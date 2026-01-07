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
      backgroundColor: Colors.grey.shade900,
      child: Icon(Icons.add, color: Colors.deepPurple, size: 40),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Todo"),
              content: TextField(controller: _controller, autofocus: true),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("İptal"),
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
                  child: Text("Kaydet"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
