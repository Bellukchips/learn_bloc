import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/todos/todos_bloc.dart';
import 'package:todos_app/views/detail/detail_screen.dart';
import 'package:todos_app/widgets/widgets.dart';

import 'package:todos_app_core/todos_app_core.dart';

class FilteredTodos extends StatelessWidget {
  const FilteredTodos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);

    return BlocBuilder<FilteredtodosBloc, FilteredtodosState>(
      builder: (context, state) {
        if (state is FilteredtodosLoadInProgress) {
          return LoadingIndicator(
            key: ArchSampleKeys.todosLoading,
          );
        } else if (state is FilteredtodosLoadSuccess) {
          final todos = state.filteredTodos;
          return ListView.builder(
            key: ArchSampleKeys.todoList,
            itemCount: todos.length,
            itemBuilder: (ctx, index) {
              final todo = todos[index];
              return TodoItem(
                todo: todo,
                onDismissed: (direction) {
                  BlocProvider.of<TodosBloc>(context).add(TodosDeleted(todo));
                  ScaffoldMessenger.of(context).showSnackBar(DeleteTodoSnackBar(
                    todo: todo,
                    onUndo: () => BlocProvider.of<TodosBloc>(context)
                        .add(TodosAdded(todo)),
                    localizations: localizations,
                    key: ArchSampleKeys.snackbar,
                  ));
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailScreen(id: todo.id);
                    }),
                  );
                  if (removedTodo != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      DeleteTodoSnackBar(
                        key: ArchSampleKeys.snackbar,
                        todo: todo,
                        onUndo: () => BlocProvider.of<TodosBloc>(context)
                            .add(TodosAdded(todo)),
                        localizations: localizations,
                      ),
                    );
                  }
                },
                onCheckboxChanged: (_) {
                  BlocProvider.of<TodosBloc>(context).add(
                      TodosUpdated(todo.copyWith(complete: !todo.complete)));
                },
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
