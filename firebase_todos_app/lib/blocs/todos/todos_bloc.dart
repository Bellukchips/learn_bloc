import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_todos_app/blocs/todos/todos.dart';
import 'package:todo_repository/todo_repository.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({required TodoRepository todosRepository})
      : _todosRepository = todosRepository,
        super(TodosLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodos>(_onAddTodo);
    on<UpdatingTodos>(_onUpdateTodo);
    on<DeleteTodos>(_onDeleteTodo);
    on<ToggleAllTodos>(_onToggleAll);
    on<ClearCompleteTodos>(_onClearCompleted);
    on<TodosUpdated>(_onTodosUpdated);
  }

  final TodoRepository _todosRepository;

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) {
    return emit.onEach<List<Todo>>(
      _todosRepository.todos(),
      onData: (todos) => add(TodosUpdated(todos)),
    );
  }

  void _onAddTodo(AddTodos event, Emitter<TodosState> emit) {
    _todosRepository.addNewTodo(event.todo);
  }

  void _onUpdateTodo(UpdatingTodos event, Emitter<TodosState> emit) {
    _todosRepository.updateTodo(event.updateTodos);
  }

  void _onDeleteTodo(DeleteTodos event, Emitter<TodosState> emit) {
    _todosRepository.deleteTodo(event.todo);
  }

  void _onToggleAll(ToggleAllTodos event, Emitter<TodosState> emit) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final allComplete = currentState.todos.every((todo) => todo.complete!);
      final List<Todo> updatedTodos = currentState.todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      updatedTodos.forEach((updatedTodo) {
        _todosRepository.updateTodo(updatedTodo);
      });
    }
  }

  void _onClearCompleted(ClearCompleteTodos event, Emitter<TodosState> emit) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final List<Todo> completedTodos =
          currentState.todos.where((todo) => todo.complete!).toList();
      completedTodos.forEach((completedTodo) {
        _todosRepository.deleteTodo(completedTodo);
      });
    }
  }

  void _onTodosUpdated(TodosUpdated event, Emitter<TodosState> emit) {
    emit(TodosLoaded(event.todo));
  }
}
