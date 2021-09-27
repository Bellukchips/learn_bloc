import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/blocs.dart';
import 'package:todos_app/flutter_todos_keys.dart';
import 'package:todos_app/models/models.dart';
import 'package:todos_app_core/todos_app_core.dart';

class ExtraActions extends StatelessWidget {
  ExtraActions({Key key}) : super(key: ArchSampleKeys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(builder: (context, state) {
      if (state is TodosLoadSuccess) {
        bool allComplete =
            (BlocProvider.of<TodosBloc>(context).state as TodosLoadSuccess)
                .todos
                .every((element) => element.complete);
        return PopupMenuButton<ExtraAction>(
          key: FlutterTodosKeys.extraActionsPopupMenuButton,
          onSelected: (action) {
            switch (action) {
              case ExtraAction.clearCompleted:
                BlocProvider.of<TodosBloc>(context).add(ClearCompleted());
                break;
              case ExtraAction.toggleAllComplete:
                BlocProvider.of<TodosBloc>(context).add(ToggleAll());
                break;
            }
          },
          itemBuilder: (BuildContext ctx) => <PopupMenuItem<ExtraAction>>[
            PopupMenuItem<ExtraAction>(
              key: ArchSampleKeys.toggleAll,
              value: ExtraAction.toggleAllComplete,
              child: Text(allComplete
                  ? ArchSampleLocalizations.of(context).markAllComplete
                  : ArchSampleLocalizations.of(context).markAllIncomplete),
            ),
            PopupMenuItem<ExtraAction>(
              key: ArchSampleKeys.clearCompleted,
              value: ExtraAction.clearCompleted,
              child: Text(ArchSampleLocalizations.of(context).clearCompleted),
            ),
          ],
        );
      }
      return Container(
        key: FlutterTodosKeys.extraActionEmptyContainer,
      );
    });
  }
}
