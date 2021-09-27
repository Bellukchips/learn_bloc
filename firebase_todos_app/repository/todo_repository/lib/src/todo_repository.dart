import 'dart:async';
import 'package:todo_repository/todo_repository.dart';

abstract class TodoRepository {
  Future<void> addNewTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
  Stream<List<Todo>> todos();
  Future<void> updateTodo(Todo todo);
}
