import 'package:firebase_todos_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:todo_repository/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final Todo? todo;
  const AddEditScreen({
    Key? key,
    required this.isEditing,
    this.todo,
  }) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController taskController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit todo ' : 'Add todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: taskController,
                  autofocus: !isEditing,
                  style: textTheme.headline5,
                  decoration:
                      InputDecoration(hintText: 'What needs to be done ?'),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                ),
                TextFormField(
                  controller: noteController,
                  maxLength: 10,
                  style: textTheme.subtitle1,
                  decoration: InputDecoration(
                    hintText: 'Additional notes...',
                  ),
                  onSaved: (value) => noteController.text = value!,
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final currentState = _formKey.currentState;
          if (currentState != null && currentState.validate()) {
            currentState.save();
            context.read<TodosBloc>().add(AddTodos(
                Todo(task: taskController.text, note: noteController.text)));
            // final task = _task;
            // if (task != null) widget.onSave(task, _note);
            Navigator.pushNamed(context, '/');
          }
          if (isEditing) {
            print("Edit");
          }
          print('add');
        },
        tooltip: isEditing ? 'Save changes' : 'Add todo',
        child: Icon(isEditing ? Icons.check : Icons.add),
      ),
    );
  }
}
