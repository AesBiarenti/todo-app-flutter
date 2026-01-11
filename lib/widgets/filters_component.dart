import 'package:basic_todo_app/constants/app_colors.dart';
import 'package:basic_todo_app/constants/enum.dart';
import 'package:basic_todo_app/providers/todo_provider.dart';
import 'package:basic_todo_app/widgets/tooltip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersComponent extends ConsumerStatefulWidget {
  const FiltersComponent({super.key});

  @override
  ConsumerState<FiltersComponent> createState() => _FiltersComponentState();
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
          backGroundColor: AppColors.getFilterActiveBackground(
            TodoEnum.all,
            currentFilter,
          ),
          textColor: AppColors.getFilterActiveText(TodoEnum.all, currentFilter),
        ),
        ToolTipWidget(
          text: "Tamamlanmış",
          onTap: () {
            ref.read(filteredTodoList.notifier).state = TodoEnum.completed;
          },
          backGroundColor: AppColors.getFilterActiveBackground(
            TodoEnum.completed,
            currentFilter,
          ),
          textColor: AppColors.getFilterActiveText(TodoEnum.completed, currentFilter),
        ),
        ToolTipWidget(
          text: "Tamamlanmamış",
          onTap: () {
            ref.read(filteredTodoList.notifier).state = TodoEnum.active;
          },
            backGroundColor: AppColors.getFilterActiveBackground(
            TodoEnum.active,
            currentFilter,
          ),
          textColor: AppColors.getFilterActiveText(TodoEnum.active, currentFilter),
        ),
      ],
    );
  }
}
