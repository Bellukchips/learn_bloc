part of 'stats_bloc.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();

  @override
  List<Object> get props => [];
}

class StastUpdated extends StatsEvent {
  final List<Todo> todos;

  StastUpdated(this.todos);
  @override
  List<Object> get props => [todos];

  @override
  String toString() {
    return 'StatsUpdated {todos: $todos}';
  }
}
