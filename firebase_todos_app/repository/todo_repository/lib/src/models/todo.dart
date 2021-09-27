import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../entities/entities.dart';

@immutable
class Todo {
  final String? id;
  final String? note;
  final String? task;
  final bool? complete;

  Todo(
      {required this.task,
      this.complete = false,
      String? id,
      String? note = ''})
      : this.note = note ?? '',
        this.id = id ?? Uuid().v4();

  Todo copyWith({
    String? note,
    String? task,
    bool? complete,
  }) {
    return Todo(
      id: id,
      note: note ?? this.note,
      task: task ?? this.task,
      complete: complete ?? this.complete,
    );
  }

  @override
  int get hashCode {
    return complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Todo &&
            runtimeType == other.runtimeType &&
            complete == other.complete &&
            task == other.task &&
            note == other.note &&
            id == other.id;
  }

  @override
  String toString() {
    return 'Todo{complete: $complete, task: $task, note: $note, id:$id}';
  }

  TodoEntity todoEntity() {
    return TodoEntity(id: id, task: task, complete: complete);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
        task: entity.task,
        id: entity.id,
        complete: entity.complete,
        note: entity.note);
  }
}
