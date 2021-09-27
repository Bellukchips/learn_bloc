import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_todos_app/blocs/stats/stats.dart';
import 'package:firebase_todos_app/blocs/todos/todos.dart';

class StatistikBloc extends Bloc<StatistikEvent, StatistikState> {
  late StreamSubscription _todosSubcription;

  StatistikBloc({required TodosBloc todosBloc}) : super(StatsLoading()) {
    on<StatsUpdated>(_onStatsUpdated);
    final todosState = todosBloc.state;
    if (todosState is TodosLoaded) add(StatsUpdated(todosState.todos));
    _todosSubcription = todosBloc.stream.listen((state) {
      if (state is TodosLoaded) {
        add(StatsUpdated(state.todos));
      }
    });
  }

  void _onStatsUpdated(StatsUpdated event, Emitter<StatistikState> emit) async {
    final numActive =
        event.todos.where((todo) => !todo.complete!).toList().length;
    final numCompleted =
        event.todos.where((todo) => todo.complete!).toList().length;
    emit(StatsLoaded(numActive, numCompleted));
  }

  @override
  Future<void> close() {
    _todosSubcription.cancel();
    return super.close();
  }
}
