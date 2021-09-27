import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_todos_app/blocs/filter/filter.dart';
import 'package:firebase_todos_app/blocs/todos/todos.dart';
import 'package:firebase_todos_app/blocs/todos/todos_bloc.dart';
import 'package:firebase_todos_app/models/models.dart';
import 'package:todo_repository/todo_repository.dart';

export '../todos/todos_bloc.dart';

class FilteredtodosBloc extends Bloc<FilteredtodosEvent, FilteredtodosState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todosSubscription;

  FilteredtodosBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(
          todosBloc.state is TodosLoaded
              ? FilteredTodosLoaded(
                  (todosBloc.state as TodosLoaded).todos,
                  VisibilityFilter.all,
                )
              : FilteredTodosLoading(),
        ) {
    on<UpdateFilter>(_onUpdateFilter);
    on<UpdateTodos>(_onUpdateTodos);
    _todosSubscription = todosBloc.stream.listen((state) {
      if (state is TodosLoaded) add(UpdateTodos(state.todos));
    });
  }

  void _onUpdateFilter(UpdateFilter event, Emitter<FilteredtodosState> emit) {
    final state = _todosBloc.state;
    if (state is TodosLoaded) {
      emit(FilteredTodosLoaded(
        _mapTodosToFilteredTodos(state.todos, event.filter),
        event.filter,
      ));
    }
  }

  void _onUpdateTodos(UpdateTodos event, Emitter<FilteredtodosState> emit) {
    final state = this.state;
    final visibilityFilter = state is FilteredTodosLoaded
        ? state.activeFilter
        : VisibilityFilter.all;
    emit(
      FilteredTodosLoaded(
        _mapTodosToFilteredTodos(
          (_todosBloc.state as TodosLoaded).todos,
          visibilityFilter,
        ),
        visibilityFilter,
      ),
    );
  }

  List<Todo> _mapTodosToFilteredTodos(
    List<Todo> todos,
    VisibilityFilter filter,
  ) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete!;
      } else {
        return todo.complete!;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    _todosSubscription.cancel();
    return super.close();
  }
}
