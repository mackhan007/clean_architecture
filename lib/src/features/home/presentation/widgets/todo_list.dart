import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/configs/app_configs.dart';
import '../../../../core/functions/show_delete_dialog.dart';
import '../../domain/entities/todo.dart';
import '../blocs/todo_bloc/todo_bloc.dart';
import 'todo_form.dart';
import 'todo_item_tile.dart';

/// {@template todo_list_view}
/// A list of [TodoItemTile]s.
///
/// [todos] is a list of [Todo]s.
/// {@endtemplate}
class TodoList extends StatelessWidget {
  /// {@macro todo_list_view}
  const TodoList({
    Key? key,
    required this.todos,
  }) : super(key: key);

  /// The list of [Todo]s to display.
  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItemTile(
          // To improve the performance of the scroll, we use provide
          // a custom unique key for each item.
          key: ValueKey(todo.id),
          index: index,
          todo: todo,
          onTap: () => _updateTodo(context, todo),
          onLongPress: (data) => _showTodoMenu(context, todo, data),
        );
      },
      itemCount: todos.length,
      prototypeItem: TodoItemTile.prototype,
    );
  }

  void _updateTodo(BuildContext context, Todo todo) {
    final bloc = context.read<TodoBloc>();
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: Dialog(
          child: TodoFormView(todo: todo),
        ),
      ),
    );
  }

  void _showTodoMenu(
    BuildContext context,
    Todo todo,
    LongPressEndDetails data,
  ) {
    final bloc = context.read<TodoBloc>();

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        data.globalPosition.dx,
        data.globalPosition.dy,
        0,
        0,
      ),
      items: [
        PopupMenuItem(
          child: Text(localization.deleteTodo),
          onTap: () {
            Future.delayed(const Duration(milliseconds: 20), () async {
              final result = await showDeleteDialog(
                context,
                localization.deleteTodo,
                localization.deleteTodoDescription,
              );

              if (result) {
                bloc.add(
                  TodoEvent.removeTodo(todo.id),
                );
              }
            });
          },
        ),
        PopupMenuItem(
          child: Text(localization.cancel),
        ),
      ],
    );
  }
}
