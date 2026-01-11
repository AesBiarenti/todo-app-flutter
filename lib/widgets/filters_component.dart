import 'package:basic_todo_app/providers/todo_provider.dart';
import 'package:basic_todo_app/widgets/tooltip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersComponent extends ConsumerStatefulWidget {
  const FiltersComponent({super.key});

  @override
  ConsumerState<FiltersComponent> createState() => _FiltersComponentState();
}

var currentFilter = TodoEnum.all;
Color changeBackGround(TodoEnum todoEnum) {
  return currentFilter == todoEnum ? Colors.deepPurple : Colors.grey;
}

Color changeTextColor(TodoEnum todoEnum) {
  return currentFilter == todoEnum ? Colors.grey : Colors.deepPurple;
}

class _FiltersComponentState extends ConsumerState<FiltersComponent> {
  @override
  Widget build(BuildContext context) {
    currentFilter = ref.watch(filteredTodoList);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ToolTipWidget(
          text: "Hepsi",
          onTap: () {
            ref.read(filteredTodoList.notifier).state = TodoEnum.all;
          },
          backGroundColor: changeBackGround(TodoEnum.all),
          textColor: changeTextColor(TodoEnum.all),
        ),
        ToolTipWidget(
          text: "Tamamlanmış",
          onTap: () {
            ref.read(filteredTodoList.notifier).state = TodoEnum.completed;
          },
          backGroundColor: changeBackGround(TodoEnum.completed),
          textColor: changeTextColor(TodoEnum.completed),
        ),
        ToolTipWidget(
          text: "Tamamlanmamış",
          onTap: () {
            ref.read(filteredTodoList.notifier).state = TodoEnum.active;
          },
          backGroundColor: changeBackGround(TodoEnum.active),
          textColor: changeTextColor(TodoEnum.active),
        ),
      ],
    );
  }
}
