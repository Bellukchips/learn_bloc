import 'package:equatable/equatable.dart';
import 'package:firebase_todos_app/models/models.dart';
import 'package:todo_repository/todo_repository.dart';

abstract class FilteredtodosEvent extends Equatable {
  const FilteredtodosEvent();
}

class UpdateFilter extends FilteredtodosEvent {
  final VisibilityFilter filter;

  UpdateFilter(this.filter);

  @override
  List<Object?> get props => [filter];

  @override
  String toString() {
    return "Updated Filter {filter : $filter}";
  }
}

class UpdateTodos extends FilteredtodosEvent {
  final List<Todo> todos;

  UpdateTodos(this.todos);
  @override
  List<Object?> get props => [todos];
  @override
  String toString() {
    return "UpdatedTodos {todos: $todos}";
  }
}
