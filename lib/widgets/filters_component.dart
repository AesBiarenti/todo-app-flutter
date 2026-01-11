import 'package:basic_todo_app/providers/todo_provider.dart';
import 'package:basic_todo_app/widgets/tooltip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersComponent extends ConsumerStatefulWidget {
  const FiltersComponent({super.key});

  @override
  ConsumerState<FiltersComponent> createState() => _FiltersComponentState();
}

Color changeBackGround(TodoEnum todoEnum, TodoEnum currentFilter) {
  return currentFilter == todoEnum ? Colors.deepPurple : Colors.grey;
}

Color changeTextColor(TodoEnum todoEnum, TodoEnum currentFilter) {
  return currentFilter == todoEnum ? Colors.grey : Colors.deepPurple;
}

class _FiltersComponentState extends ConsumerState<FiltersComponent> {
  @override
  Widget build(BuildContext context) {
    final currentFilter = ref.watch(filteredTodoList);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ToolTipWidget(
          text: "Hepsi",
          onTap: () {
            ref.read(filteredTodoList.notifier).state = TodoEnum.all;
          },
          backGroundColor: changeBackGround(TodoEnum.all, currentFilter),
          textColor: changeTextColor(TodoEnum.all, currentFilter),
        ),
        ToolTipWidget(
          text: "Tamamlanmış",
          onTap: () {
            ref.read(filteredTodoList.notifier).state = TodoEnum.completed;
          },
          backGroundColor: changeBackGround(TodoEnum.completed, currentFilter),
          textColor: changeTextColor(TodoEnum.completed, currentFilter),
        ),
        ToolTipWidget(
          text: "Tamamlanmamış",
          onTap: () {
            ref.read(filteredTodoList.notifier).state = TodoEnum.active;
          },
          backGroundColor: changeBackGround(TodoEnum.active, currentFilter),
          textColor: changeTextColor(TodoEnum.active, currentFilter),
        ),
      ],
    );
  }
}
