part of 'filteredtodos_bloc.dart';

abstract class FilteredtodosEvent extends Equatable {
  const FilteredtodosEvent();

  @override
  List<Object> get props => [];
}

class FilterUpdated extends FilteredtodosEvent {
  final VisibilityFilter filter;

  const FilterUpdated(this.filter);
  @override
  List<Object> get props => [filter];

  @override
  String toString() {
    return 'Filterd updated {filter: $filter}';
  }
}

class TodosUpdated extends FilteredtodosEvent {
  final List<Todo> todos;

  TodosUpdated(this.todos);
  @override
  List<Object> get props => [todos];

  @override
  String toString() {
    return 'TodosUpdated {todosL $todos}';
  }
}
