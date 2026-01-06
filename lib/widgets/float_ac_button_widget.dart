import 'package:flutter/material.dart';

class FloatAcButtonWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function addTodo;
  const FloatAcButtonWidget({
    super.key,
    required this.textEditingController,
    required this.addTodo,
  });

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
              content: TextField(controller: textEditingController),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    addTodo();
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
