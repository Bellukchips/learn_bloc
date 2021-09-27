part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class TodosLoaded extends TodosEvent {}

class TodosAdded extends TodosEvent {
  final Todo todo;

  const TodosAdded(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() {
    return 'TodosAdded {todo : $todo}';
  }
}

class TodosUpdated extends TodosEvent {
  final Todo todo;

  const TodosUpdated(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() {
    return 'TodosUpdated {todo : $todo}';
  }
}

class TodosDeleted extends TodosEvent {
  final Todo todo;

  const TodosDeleted(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() {
    return 'TodosDeleted {todo : $todo}';
  }
}

class ClearCompleted extends TodosEvent {}

class ToggleAll extends TodosEvent {}
