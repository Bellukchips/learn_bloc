import 'package:firebase_todos_app/blocs/blocs.dart';
import 'package:firebase_todos_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtraActions extends StatelessWidget {
  const ExtraActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(builder: (ctx, state) {
      if (state is TodosLoaded) {
        final allComplete = state.todos.every((element) => element.complete!);
        return PopupMenuButton<ExtraAction>(
          onSelected: (action) {
            switch (action) {
              case ExtraAction.clearComplete:
                context.read<TodosBloc>().add(ClearCompleteTodos());
                break;
              case ExtraAction.toggleAllComplete:
                context.read<TodosBloc>().add(ToggleAllTodos());
                break;
            }
          },
          itemBuilder: (ctx) => <PopupMenuItem<ExtraAction>>[
            PopupMenuItem<ExtraAction>(
              value: ExtraAction.toggleAllComplete,
              child: Text(
                  allComplete ? 'Mark all incomplete' : 'Mark all complete'),
            ),
            PopupMenuItem<ExtraAction>(
                value: ExtraAction.clearComplete, child: Text('Clear Complete'))
          ],
        );
      }
      return Container();
    });
  }
}
