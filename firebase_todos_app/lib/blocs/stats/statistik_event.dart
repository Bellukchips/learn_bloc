import 'package:equatable/equatable.dart';
import 'package:todo_repository/todo_repository.dart';

abstract class StatistikEvent extends Equatable {
  const StatistikEvent();
}

class StatsUpdated extends StatistikEvent {
  final List<Todo> todos;

  StatsUpdated(this.todos);

  @override
  List<Object?> get props => [todos];

  @override
  String toString() {
    return "StatsUpdated {todos: $todos}";
  }
}
