import 'package:firebase_todos_app/blocs/blocs.dart';
import 'package:firebase_todos_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatelessWidget {
  final String id;
  const DetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (ctxt, state) {
        if (state is! TodosLoaded) {
          throw StateError('Cannot render details without a valid todo');
        }

        final todo = state.todos.firstWhere((element) => element.id == id);
        return Scaffold(
          appBar: AppBar(
            title: Text('Todo details'),
            actions: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  context.read<TodosBloc>().add(DeleteTodos(todo));
                  Navigator.of(context).pop(context);
                },
                tooltip: 'Delete todo',
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Checkbox(
                        value: todo.complete,
                        onChanged: (_) {
                          context
                              .read<TodosBloc>()
                              .add(UpdatingTodos(todo.copyWith(
                                complete: todo.complete == false,
                              )));
                        },
                      ),
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
                                todo.task!,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ),
                          Text(
                            todo.note!,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return AddEditScreen(
              //         onSave: (task, note) {
              //           context.read<TodosBloc>().add(
              //                 UpdatingTodos(
              //                     todo.copyWith(task: task, note: note)),
              //               );
              //         },
              //         isEditing: true,
              //         todo: todo,
              //       );
              //     },
              //   ),
              // );
            },
            tooltip: 'Edit todo',
            child: Icon(Icons.edit),
          ),
        );
      },
    );
  }
}
