import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../blocs.dart';
import 'package:todos_app/models/filtered_todos_state.dart';
import 'package:todos_app/models/todo.dart';
import 'package:flutter/material.dart';
part 'filteredtodos_event.dart';
part 'filteredtodos_state.dart';

class FilteredtodosBloc extends Bloc<FilteredtodosEvent, FilteredtodosState> {
  final TodosBloc todosBloc;
  // ignore: cancel_subscriptions
  StreamSubscription todosSubcription;

  FilteredtodosBloc({@required this.todosBloc})
      : super(
          todosBloc?.state is TodosLoadSuccess
              ? FilteredtodosLoadSuccess(
                  (todosBloc?.state as TodosLoadSuccess).todos,
                  VisibilityFilter.all)
              : FilteredtodosLoadInProgress(),
        ) {
    todosSubcription = todosBloc.stream.listen((state) {
      if (state is TodosLoadSuccess) {
        add(TodosUpdated((todosBloc?.state as TodosLoadSuccess).todos));
      }
    });
  }
  @override
  Stream<FilteredtodosState> mapEventToState(
    FilteredtodosEvent event,
  ) async* {
    if (event is FilterUpdated) {
      yield* _mapFilterUpdatedToState(event);
    } else if (event is TodosUpdated) {
      yield* _mapTodosUpdateToState(event);
    }
  }

  Stream<FilteredtodosState> _mapFilterUpdatedToState(
      FilterUpdated event) async* {
    if (todosBloc?.state is TodosLoadSuccess) {
      yield FilteredtodosLoadSuccess(
          _mapTodosFilteredTodos(
              (todosBloc?.state as TodosLoadSuccess).todos, event.filter),
          event.filter);
    }
  }

  Stream<FilteredtodosState> _mapTodosUpdateToState(TodosUpdated event) async* {
    final visibilityFilter = state is FilteredtodosLoadSuccess
        ? (state as FilteredtodosLoadSuccess).activeFilter
        : VisibilityFilter.all;

    yield FilteredtodosLoadSuccess(
        _mapTodosFilteredTodos(
            (todosBloc?.state as TodosLoadSuccess).todos, visibilityFilter),
        visibilityFilter);
  }

  List<Todo> _mapTodosFilteredTodos(List<Todo> todos, VisibilityFilter filter) {
    return todos.where((e) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !e.complete;
      } else {
        return e.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    todosSubcription?.cancel();
    return super.close();
  }
}
