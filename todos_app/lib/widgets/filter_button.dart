import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/blocs.dart';
import 'package:todos_app/models/filtered_todos_state.dart';
import 'package:todos_app_core/todos_app_core.dart';

class FilterButton extends StatelessWidget {
  final bool visible;

  const FilterButton({Key key, this.visible}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ///
    final defaultStyle = Theme.of(context).textTheme.bodyText2;
    final actieStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(color: Theme.of(context).accentColor);

    return BlocBuilder<FilteredtodosBloc, FilteredtodosState>(
      builder: (context, state) {
        final button = _Button(
          onSelect: (filter) {
            BlocProvider.of<FilteredtodosBloc>(context)
                .add(FilterUpdated(filter));
          },
          activeFilter: state is FilteredtodosLoadSuccess
              ? state.activeFilter
              : VisibilityFilter.all,
          activeStyle: actieStyle,
          defaultStyle: defaultStyle,
        );
        return AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 150),
          child: visible
              ? button
              : IgnorePointer(
                  child: button,
                ),
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  final PopupMenuItemSelected<VisibilityFilter> onSelect;
  final VisibilityFilter activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  const _Button(
      {Key key,
      this.onSelect,
      this.activeFilter,
      this.activeStyle,
      this.defaultStyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      key: ArchSampleKeys.filterButton,
      tooltip: ArchSampleLocalizations.of(context).filterTodos,
      onSelected: onSelect,
      itemBuilder: (BuildContext ctx) => <PopupMenuItem<VisibilityFilter>>[
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.allFilter,
          value: VisibilityFilter.all,
          child: Text(
            ArchSampleLocalizations.of(context).showAll,
            style: activeFilter == VisibilityFilter.all
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.activeFilter,
          value: VisibilityFilter.active,
          child: Text(
            ArchSampleLocalizations.of(context).showActive,
            style: activeFilter == VisibilityFilter.active
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.completedFilter,
          value: VisibilityFilter.completed,
          child: Text(
            ArchSampleLocalizations.of(context).showCompleted,
            style: activeFilter == VisibilityFilter.completed
                ? activeStyle
                : defaultStyle,
          ),
        ),
      ],
      icon: Icon(Icons.filter_list),
    );
  }
}
