import 'package:basic_todo_app/core/models/todo_state.dart';
import 'package:basic_todo_app/providers/todo_provider.dart';
import 'package:basic_todo_app/widgets/filters_component.dart';
import 'package:basic_todo_app/widgets/float_ac_button_widget.dart';
import 'package:basic_todo_app/widgets/listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(asyncTodoStateProvider);
    final todoNotifier = ref.read(todoStateProvider.notifier);
    final asyncNotifier = ref.read(asyncTodoStateProvider.notifier);

    // Async error durumunda snackbar göster
    if (asyncState is AsyncTodoError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(asyncState.message),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
        asyncNotifier.reset();
      });
    }

    // Async success durumunda snackbar göster
    if (asyncState is AsyncTodoSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('İşlem başarılı'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      });
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatAcButtonWidget(
          addTodo: (text) async {
            asyncNotifier.setLoading();
            try {
              await todoNotifier.addTodo(text);
              asyncNotifier.setSuccess();
            } catch (e) {
              asyncNotifier.setError('Todo eklenirken bir hata oluştu');
            }
          },
        ),
        body: Column(
          children: [
            Expanded(child: FiltersComponent()),
            Expanded(flex: 10, child: ListViewWidget()),
          ],
        ),
      ),
    );
  }
}
