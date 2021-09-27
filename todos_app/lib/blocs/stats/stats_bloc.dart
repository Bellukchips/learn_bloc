import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_app/blocs/blocs.dart';
import 'package:todos_app/models/todo.dart';
import 'package:flutter/material.dart';
part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TodosBloc todosBloc;
  // ignore: cancel_subscriptions
  StreamSubscription todosSubcription;

  StatsBloc({@required this.todosBloc}) : super(StatsLoadInProgress()) {
    void onTodosStateChanged(state) {
      if (state is TodosLoadSuccess) {
        add(StastUpdated(state.todos));
      }
    }

    onTodosStateChanged(todosBloc?.state);
    todosSubcription = todosBloc.stream.listen(onTodosStateChanged);
  }
  @override
  Stream<StatsState> mapEventToState(
    StatsEvent event,
  ) async* {
    if (event is StastUpdated) {
      final numActive =
          event.todos.where((element) => !element.complete).toList().length;
      final numCompleted =
          event.todos.where((element) => element.complete).toList().length;
      yield StatsLoadSuccess(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    todosSubcription?.cancel();
    return super.close();
  }
}
