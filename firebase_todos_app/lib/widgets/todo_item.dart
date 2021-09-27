import 'package:flutter/material.dart';
import 'package:todo_repository/todo_repository.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool?> onCheckboxChanged;
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.onDismissed,
    required this.onTap,
    required this.onCheckboxChanged,
    required this.todo,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: Key('__todo_item_${todo.id}'),
      onDismissed: onDismissed,
      child: ListTile(
          onTap: onTap,
          leading: Checkbox(value: todo.complete, onChanged: onCheckboxChanged),
          title: Hero(
            tag: '${todo.id}',
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                todo.task!,
                style: theme.textTheme.headline6,
              ),
            ),
          ),
          subtitle: todo.note!.isNotEmpty
              ? Text(
                  todo.note!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.subtitle1,
                )
              : null),
    );
  }
}
