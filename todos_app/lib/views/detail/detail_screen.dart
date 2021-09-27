import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/blocs.dart';
import 'package:todos_app/flutter_todos_keys.dart';
import 'package:todos_app/views/views.dart';
import 'package:todos_app_core/todos_app_core.dart';

class DetailScreen extends StatelessWidget {
  final String id;
  DetailScreen({Key key, @required this.id})
      : super(key: key ?? ArchSampleKeys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        //
        final todo = (state as TodosLoadSuccess)
            .todos
            // ignore: null_check_always_fails
            .firstWhere((todo) => todo.id == id, orElse: () => null);

        //
        final localizations = ArchSampleLocalizations.of(context);
        //
        return Scaffold(
          appBar: AppBar(
            title: Text(localizations.todoDetails),
            actions: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<TodosBloc>(context).add(TodosDeleted(todo));
                  Navigator.pop(context, todo);
                },
                tooltip: localizations.deleteTodo,
                key: ArchSampleKeys.deleteTodoButton,
              )
            ],
          ),
          body: todo == null
              ? Container(
                  key: FlutterTodosKeys.emptyDetailContainer,
                )
              : Padding(
                  padding: EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Checkbox(
                              key: FlutterTodosKeys.detailsScreenCheckBox,
                              value: todo.complete,
                              onChanged: (_) {
                                BlocProvider.of<TodosBloc>(context).add(
                                    TodosUpdated(todo.copyWith(
                                        complete: !todo.complete)));
                              },
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: '${todo.id}__heroTag',
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: 16.0,
                              ),
                              child: Text(
                                todo.task,
                                key: ArchSampleKeys.detailsTodoItemTask,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ),
                          Text(
                            todo.note,
                            key: ArchSampleKeys.detailsTodoItemNote,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.editTodoFab,
            tooltip: localizations.editTodo,
            child: Icon(Icons.edit),
            onPressed: todo == null
                ? null
                : () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return AddEditScreen(
                        key: ArchSampleKeys.editTodoScreen,
                        onSaveCallback: (task, note) {
                          BlocProvider.of<TodosBloc>(context).add(TodosUpdated(
                              todo.copyWith(task: task, note: note)));
                        },
                        isEditing: true,
                        todo: todo,
                      );
                    }));
                  },
          ),
        );
      },
    );
  }
}
