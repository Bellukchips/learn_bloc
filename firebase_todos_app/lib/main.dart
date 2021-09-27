import 'package:firebase_todos_app/blocs/blocs.dart';
import 'package:firebase_todos_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_repository/todo_repository.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  runApp(TodosApp());
}

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(
              userRepository: FirebaseUserRepository(),
            )..add(AppStarted());
          },
        ),
        BlocProvider<TodosBloc>(
          create: (context) {
            return TodosBloc(
              todosRepository: FirestoreTodoRepository(),
            )..add(LoadTodos());
          },
        )
      ],
      child: MaterialApp(
        title: 'Firestore Todos',
        routes: {
          '/': (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<TabBloc>(
                        create: (context) => TabBloc(),
                      ),
                      BlocProvider<FilteredtodosBloc>(
                        create: (context) => FilteredtodosBloc(
                          todosBloc: context.read<TodosBloc>(),
                        ),
                      ),
                      BlocProvider<StatistikBloc>(
                        create: (context) => StatistikBloc(
                          todosBloc: context.read<TodosBloc>(),
                        ),
                      ),
                    ],
                    child: HomeScreen(),
                  );
                }
                if (state is Unauthenticated) {
                  return Center(
                    child: Text('Could not authenticate with Firestore'),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          },
          // '/addTodo': (context) {
          //   return AddEditScreen(
          //     onSave: (task, note) {
          //       context
          //           .read<TodosBloc>()
          //           .add(AddTodos(Todo(task: task, note: note)));
          //     },
          //     isEditing: false,
          //   );
          // },
        },
      ),
    );
  }
}
