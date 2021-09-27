import 'package:equatable/equatable.dart';
import 'package:firebase_todos_app/models/models.dart';
import 'package:todo_repository/todo_repository.dart';

abstract class FilteredtodosState extends Equatable {
  const FilteredtodosState();

  @override
  List<Object> get props => [];
}

class FilteredTodosLoading extends FilteredtodosState {}

class FilteredTodosLoaded extends FilteredtodosState {
  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  FilteredTodosLoaded(this.filteredTodos, this.activeFilter);

  @override
  List<Object> get props => [filteredTodos, activeFilter];

  @override
  String toString() {
    return "FilteredTodosLoaded {filteredTodos : $filteredTodos, activeFilter : $activeFilter}";
  }
}
