import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_repository/todo_repository.dart';

class FirestoreTodoRepository extends TodoRepository {
  final _todoCollection = FirebaseFirestore.instance.collection('todos');

  @override
  Future<void> addNewTodo(Todo todo) {
    return _todoCollection.doc(todo.id).set((todo.todoEntity().toDocument()));
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    return _todoCollection.doc(todo.id).delete();
  }

  @override
  Stream<List<Todo>> todos() {
    return _todoCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((e) => Todo.fromEntity(TodoEntity.fromSnapshot(e)))
          .toList();
    });
  }

  @override
  Future<void> updateTodo(Todo todo) {
    return _todoCollection.doc(todo.id).update(todo.todoEntity().toDocument());
  }
}
