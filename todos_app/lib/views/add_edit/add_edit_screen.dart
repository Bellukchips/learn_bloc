import 'package:flutter/material.dart';

import 'package:todos_app/models/models.dart';
import 'package:todos_app_core/todos_app_core.dart';

typedef OnSaveCallback = Function(String task, String note);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSaveCallback;
  final Todo todo;
  AddEditScreen({
    Key key,
    this.isEditing,
    this.onSaveCallback,
    this.todo,
  }) : super(key: key ?? ArchSampleKeys.addTodoScreen);
  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  bool get isEditing => widget.isEditing;
  @override
  Widget build(BuildContext context) {
    final localization = ArchSampleLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? localization.editTodo : localization.addTodo),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.todo.task : '',
                key: ArchSampleKeys.taskField,
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(hintText: localization.newTodoHint),
                validator: (error) {
                  return error.trim().isEmpty
                      ? localization.emptyTodoError
                      : null;
                },
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.todo.note : '',
                key: ArchSampleKeys.noteField,
                autofocus: !isEditing,
                maxLength: 10,
                style: textTheme.headline1,
                decoration: InputDecoration(hintText: localization.notesHint),
                onSaved: (value) => _task = value,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key:
            isEditing ? ArchSampleKeys.saveTodoFab : ArchSampleKeys.saveNewTodo,
        tooltip: isEditing ? localization.saveChanges : localization.addTodo,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSaveCallback(_task, _note);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
