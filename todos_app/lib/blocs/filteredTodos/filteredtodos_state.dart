part of 'filteredtodos_bloc.dart';

abstract class FilteredtodosState extends Equatable {
  const FilteredtodosState();

  @override
  List<Object> get props => [];
}

class FilteredtodosLoadInProgress extends FilteredtodosState {}

class FilteredtodosLoadSuccess extends FilteredtodosState {
  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  const FilteredtodosLoadSuccess(this.filteredTodos, this.activeFilter);

  @override
  List<Object> get props => [filteredTodos, activeFilter];

  @override
  String toString() {
    return 'FilteredtodosLoadSuccess {filteredTodos: $filteredTodos, activeFilter: $activeFilter}';
  }
}
