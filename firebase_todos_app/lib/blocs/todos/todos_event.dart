import 'package:equatable/equatable.dart';
import 'package:todo_repository/todo_repository.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodosEvent {}

class AddTodos extends TodosEvent {
  final Todo todo;

  AddTodos(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() {
    return "AddTodo : {todo : $todo}";
  }
}

class UpdatingTodos extends TodosEvent {
  final Todo updateTodos;

  UpdatingTodos(this.updateTodos);

  @override
  List<Object> get props => [updateTodos];

  @override
  String toString() {
    return "UpdateTodos : {todo : $updateTodos}";
  }
}

class DeleteTodos extends TodosEvent {
  final Todo todo;

  DeleteTodos(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() {
    return "DeleteTodo : {todo : $todo}";
  }
}

class ClearCompleteTodos extends TodosEvent {}

class ToggleAllTodos extends TodosEvent {}

class TodosUpdated extends TodosEvent {
  final List<Todo> todo;

  TodosUpdated(this.todo);

  @override
  List<Object> get props => [todo];
}
