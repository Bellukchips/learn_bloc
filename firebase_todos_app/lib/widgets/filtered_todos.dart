import 'package:firebase_todos_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets.dart';

class FilteredTodos extends StatelessWidget {
  const FilteredTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredtodosBloc, FilteredtodosState>(
        builder: (ctx, state) {
      if (state is FilteredTodosLoading) {
        return LoadingIndicator();
      } else if (state is FilteredTodosLoaded) {
        final todos = state.filteredTodos;
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return TodoItem(
              todo: todo,
              onDismissed: (direction) {
                context.read<TodosBloc>().add(DeleteTodos(todo));
                ScaffoldMessenger.of(context).showSnackBar(DeleteTodoSnackBar(
                    todo: todo,
                    onUndo: () {
                      context.read<TodosBloc>().add(AddTodos(todo));
                    }));
              },
              onTap: () async {
                // final removedTodo = await Navigator.of(context).push(
                //     MaterialPageRoute(builder: (_) {
                //       return DetailsScreen(id: todo.id);
                //     }),
                //   );
                // if (removedTodo != null) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     DeleteTodoSnackBar(
                //       todo: todo,
                //       onUndo: () {
                //         context.read<TodosBloc>().add(AddTodos(todo));
                //       },
                //     ),
                //   );
                // }
              },
              onCheckboxChanged: (_) {
                context.read<TodosBloc>().add(
                    UpdatingTodos(todo.copyWith(complete: !todo.complete!)));
              },
            );
          },
        );
      } else {
        return Container();
      }
    });
  }
}
